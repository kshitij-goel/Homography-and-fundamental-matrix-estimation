function [  ] = plot_triang( tripts, camcen1, camcen2 )
%PLOT_TRIANGULATION Summary of this function goes here
%   Detailed explanation goes here

    figure; axis equal;  hold on; 
    plot3(-tripts(:,1), tripts(:,2), tripts(:,3), '.r');
    plot3(-camcen1(1), camcen1(2), camcen1(3),'*g');
    plot3(-camcen2(1), camcen2(2), camcen2(3),'*b');
    grid on; xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
    
end

