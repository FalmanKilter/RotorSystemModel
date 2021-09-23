% main function
clc; clear; close all;

%% load static configuration
[geometry_params,...
    operational_params] = load_static_config();

%% initialise mesh
[calc_mesh, delta_mesh] = initialise_mesh();

%% initialise radial gap - static calculation

% initial position of the shaft centre in the bearing - non-dimensional, 
% actual position in microns divided by mean radial gap, the first element
% is along the horizontal axis and the second is along the vertical axis in
% Cartesian coordinates
init_position = [0.5 0.5];

radial_gap = repmat(1 - init_position(1)*sin(calc_mesh(:)*2*pi) - init_position(2)*cos(calc_mesh(:)*2*pi), 1, numel(calc_mesh));

mesh(calc_mesh, calc_mesh,radial_gap);
