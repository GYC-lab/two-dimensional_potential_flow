function [P,Q] = vortex(x,y)
    Gamma = 2 * pi;         % vortex strength
    r = (x.^2+y.^2).^0.5;
    theta = atan2(y,x);
    P = -Gamma/2/pi*theta;  % velocity potential function
    Q = Gamma/2/pi*log(r);  % streamline function
end
