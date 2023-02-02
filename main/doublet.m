function [P,Q] = doublet(x,y)
    kappa = 2 * pi;                 % doublet strength
    r = (x.^2+y.^2).^0.5;
    theta = atan2(y,x);
    P =kappa/2/pi*cos(theta)./r;    % velocity potential function
    Q =-kappa/2/pi*sin(theta)./r;   % streamline function
end