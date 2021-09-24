function [geometry_parameters,operational_parameters] = load_static_config()
% The function loads constant parameters of the system into project workspace
%   @params: none
%
%   @return: geometry_parameters - 1x3 array of elements: bearing length,
%                                    shaft radius and mean radial gap;
%            operational parameters - 1x3 array of elements: angular
%                                      velocity of the shaft, dynamic
%                                      visocity of the lubricant, ambient
%                                      pressure condition.

%% geometry - diameter, length, radial clearence
D = 0.04;           %shaft diameter;
R = D/2;
L = 0.0620;         %bearing length
h0 = 130e-6;        %mean radial gap

geometry_parameters=[L R h0];

%% operational parameters - RPM, viscosity, load
n_rpm =1488;            %rotation speed
omega = n_rpm*2*pi/60;
mu = 1.1255e-3;         %dynamic viscosity for 15.5 C
PresCond=0;             %ambient pressure condition

operational_parameters=[omega mu PresCond];

end

