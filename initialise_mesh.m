function [mesh, delta_mesh] = initialise_mesh(~)
% The function creates two axes for the mesh grid matrix and returns the
% node step along the axes
%   @params: NoN_known - if false, perform optimisation for mesh size;
%
%   @returns: mesh - array of size 1xNoN of node location,
%             delta_mesh - grid step between two nodes
%%

switch nargin
    case 0
        % these are random values, replace with once optimised parameters
        % and switch off the mesh_known flag
        NoN = [20 20];
    case 1
        % NoN = optimise_NoN();
end

mesh = linspace(0,1,NoN(1));
delta_mesh = mesh(2)-mesh(1);  
end

