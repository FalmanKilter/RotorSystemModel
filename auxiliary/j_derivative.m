function [dfdj] = j_derivative(array, dj)
% Function returns derivatives of the input array in nodes
% of the calculation grid given grid step along j(rows)
%
%   @params: array - input matrix for which the derivative is to be
%                   caluclated,
%            dj - grid step;
%
%   @returns: dfdj - derivative of the input array along the rows of the
%                   matrix

dfdj=zeros(size(array));

for i=1:size(array, 1)
    for j=1:size(array, 2)
        if j==1
            dfdj(i,j)=(-array(i,j+2)+4*array(i,j+1)-3*array(i,j))/(2*dj);
        else
            if j==size(array, 2)
                dfdj(i,j)=(3*array(i,j)-4*array(i,j-1)+array(i,j-2))/(2*dj);
            else
                dfdj(i,j)=(array(i,j+1)-array(i,j-1))/(2*dj);
            end
        end
    end
end

end

