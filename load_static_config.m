function [geometry_parameters,...
          operational_parameters] = load_static_config()
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
D = 0.04;           % shaft diameter, [m] 
R = D/2;            % shaft radius, [m]
L = 0.0620;         % bearing length, [m]
h0 = 130e-6;        % mean radial gap, [m]

geometry_parameters=[L R h0];

%% operational parameters - RPM, viscosity, load
n_rpm =1488;            % rotation speed, [rev/min]
omega = n_rpm*2*pi/60;  % angular speed, [rad/s]
mu = 1.1255e-3;         % dynamic viscosity [Pa*s] (@ temperature = 15 deg C)
PresCond=0;             % ambient pressure [Pa]

operational_parameters=[omega mu PresCond];

end

