function [P,Q] = source_sink(x,y,x_0,Lambda)
%     Lambda = 2 * pi;        % source strength
    x = x - x_0;
    r = (x.^2+y.^2).^0.5;
    theta = atan2(y,x);
    P = Lambda/2/pi*log(r); % velocity potential function
    Q = Lambda/2/pi*theta;  % streamline function
end

