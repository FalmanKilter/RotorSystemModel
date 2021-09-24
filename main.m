% main function
clc; clear; close all;
%%
% geometry_parameters - bearing length,
%                       shaft radius
%                       mean radial gap;
% operational parameters - angular velocity of the shaft, 
%                          dynamic visocity of the lubricant, 
%                          ambient pressure condition.
%% load static configuration
[geometry_params,...
    operational_params] = load_static_config();

disp('Static configuration loaded.');

%% initialise mesh
[calc_mesh, delta_mesh] = initialise_mesh();

disp('Calculation mesh initialised.');

%% additional parameters claculation
% characteristic time for a shaft revolution given omega, [s]
t_char = 2*pi/operational_params(1);

% ratio between mean radial gap and bearing radius
mean_gap_to_radius = geometry_params(3)/geometry_params(2);


%...

%% initialise radial gap - static calculation

% initial state of the system - non-dimensional
% init_state(1) - position along i,
% init_state(2) - velocity along i,
% init_state(3) - position along j,
% init_state(4) - velocity along j
% init_state(1 or 3)_phys = init_state(1 or 3)*geometry_params(3) - for
% physical values in [m]
init_state = [0.5 0 0.5 0];

[radial_gap, ...
    d_radial_gap_di,...
    d_radial_gap_dj] = initialise_radial_gap(init_state, ...
                                             calc_mesh, ...
                                             delta_mesh);

disp('Radial gap function initialised.')

% mesh(calc_mesh, calc_mesh,radial_gap);

%% calculate velocities of the shaft centre in [i,j]
[U, V, d_U_d_i] = calculate_velocities(operational_params,...
                                                t_char,...
                                                mean_gap_to_radius,...
                                                init_state,...
                                                calc_mesh,...
                                                delta_mesh);

% % predefine auxiliary matrices
% A=zeros(size(calc_mesh,1),size(calc_mesh,2)); D=zeros(size(calc_mesh,1),size(calc_mesh,2));
% E=zeros(size(calc_mesh,1),size(calc_mesh,2)); F=zeros(size(calc_mesh,1),size(calc_mesh,2));
% G=zeros(size(calc_mesh,1),size(calc_mesh,2)); H=zeros(size(calc_mesh,1),size(calc_mesh,2));
% K=zeros(size(calc_mesh,1),size(calc_mesh,2));

% define matrices A - K
A = radial_gap.^3;

B = i_derivative(A,delta_mesh);

C = j_derivative(A,delta_mesh);

D = 6*(radial_gap.*d_U_d_i + U.*d_radial_gap_di) - 12*V;

E = (B./(2*delta_mesh))+(A./delta_mesh^2);

F = (C./(2*delta_mesh))+(A./delta_mesh^2);

G = (-2*A/(delta_mesh^2))+(-2*A./delta_mesh^2);

H = (-B./(2*delta_mesh))+(A./delta_mesh^2);

K = (-C./(2*delta_mesh))+(A./delta_mesh^2);

% predefine the coefficient matrix 
M = numel(calc_mesh)-2;
N = M*numel(calc_mesh);

coef_matrix = zeros(N);

free_term_matrix = zeros(N,1);

for I=1:N
    
    i=ceil(I/M);
    j=I-(i-1)*M;
    
    free_term_matrix(I,1)=D(i,j);
    
    if rem(I,M)==0
        free_term_matrix(I,1)=D(i,j)-F(i,j)*operational_params(3);
        free_term_matrix(I-M+1,1)=D(i,j)-K(i,j)*operational_params(3);
    end
    for J=1:N
        if J==I
            coef_matrix(I,J)=G(i,j);
            if (J+M)<=N
                coef_matrix(I,J+M)=E(i,j);
            else
                coef_matrix(I,J-N+2*M)=E(i,j);
            end
            if I<=M
                coef_matrix(I,N-2*M+J)=H(i,j);
            else
                coef_matrix(I,J-M)=H(i,j);
            end
            if rem(I,M)~=0 && I<=N
                coef_matrix(I+1,J)=K(i,j);
                coef_matrix(I,J+1)=F(i,j);
            end
        end
    end
end

% solve [coef_matrix * pressure = free_term_matrix] for unknown pressure 
unknown = coef_matrix\free_term_matrix;

%predefine and unwrap the raw pressure matrix 
pressure_calculated = zeros(numel(calc_mesh),numel(calc_mesh) - 2);
for I=1:N
    ii = ceil(I/M);
    jj = I-(ii-1)*M;
    pressure_calculated(ii,jj) = unknown(I);
end

% add ambient pressure sondition to the calculated matrix
ambient_pressure=ones(numel(calc_mesh),1).*operational_params(3);

pressure_distribution = [ambient_pressure pressure_calculated ambient_pressure];
