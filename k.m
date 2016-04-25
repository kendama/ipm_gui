%Helper function to produce dispersal kernel
function kernel = k(x, D, beta, v)
    
    kernel = zeros(size(x), class(x));
    if v == 0
        a = sqrt(beta/D);
        indsA = x<0;
        indsB = x>=0;
        kernel(indsA) = (a/2)*(exp(a*x(indsA)));
        kernel(indsB) = (a/2)*(exp(-a*x(indsB)));
        %plot(x, kernel, '-')
        %xlabel('Position, x');
        %ylabel('Dispersal Kernel, K(x,0)');
        %title('Symmetric Laplace Kernel');
    else
        a = v/(2*D) + sqrt( (v^2)/(4*D^2) + (beta/D) );
        b = v/(2*D) - sqrt( (v^2)/(4*D^2) + (beta/D) );
        A = (a*b)/(b - a); %= beta/sqrt( v^2 + 4*beta*D);
        indsA = x<0;
        indsB = x>=0;
        kernel(indsA) = A*exp(a*x(indsA));
        kernel(indsB) = A*exp(b*x(indsB));
        %plot(x, kernel, '-')
        %xlabel('Position, x');
        %ylabel('Dispersal Kernel, K(x,0)');
        %title('Asymmetric Laplace Kernel');
    end

end