function [radial_gap, d_radial_gap_di, d_radial_gap_dj] = initialise_radial_gap(init_position, calc_mesh, delta_mesh)
% Function returns a matrix with local non-dimensional radial gap height
% and its derivatives
%
%   @params: init_poisition - initial shaft centre position in the bearing,
%                           non-dimensional,
%            calc_mesh - calculation mesh grid nodes position,
%                        non-dimensional,
%            delta_mesh - mesh grid step;
%
%   @returns: radila_gap - matrix of local radial gap height,
%             d_radial_gap_di, ..._dj - matrices of the radial gap function
%                                       derivatives along i and j

radial_gap = repmat(1 - init_position(1)*sin(calc_mesh(:)*2*pi) - init_position(2)*cos(calc_mesh(:)*2*pi), 1, numel(calc_mesh));
d_radial_gap_di = i_derivative(radial_gap, delta_mesh);
d_radial_gap_dj = j_derivative(radial_gap, delta_mesh);
end

