function [dfdi] = i_derivative(array, di)
% Function returns derivatives of the input array in nodes 
% of the calculation grid given grid step along i(columns)

%   @params: array - input matrix for which the derivative is to be
%                   caluclated,
%            di - grid step;
%
%   @returns: dfdi - derivative of the input array along the columns

dfdi=zeros(size(array));
for i=1:size(array, 1)
    for j=1:size(array, 2)
        if i==1
            dfdi(i,j)=(-array(i+2,j)+4*array(i+1,j)-3*array(i,j))/(2*di);
        else
            if i==size(array, 1)
                dfdi(i,j)=(3*array(i,j)-4*array(i-1,j)+array(i-2,j))/(2*di);
            else
                dfdi(i,j)=(array(i+1,j)-array(i-1,j))/(2*di);
            end
        end
    end
end
end

