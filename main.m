% main function
clc; clear; close all;

%% load static configuration
[geometry_params,...
    operational_params] = load_static_config();
disp('Static configuration loaded.');

%% initialise mesh
[calc_mesh, delta_mesh] = initialise_mesh();
disp('Calculation mesh initialised.');

%% initialise radial gap - static calculation

% initial position of the shaft centre in the bearing - non-dimensional
% init_position(1) - along horizontal axis,
% init_position(2) - along vertical axis
init_position = [0.5 0.5];
[radial_gap, ...
    d_radial_gap_di,...
    d_radial_gap_dj] = initialise_radial_gap(init_position, calc_mesh, delta_mesh);

disp('Radial gap function initialised.')

% mesh(calc_mesh, calc_mesh,radial_gap);


