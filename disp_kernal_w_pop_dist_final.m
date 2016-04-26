% The following program is intended to model fixed-time, continuous space
% dispersal events where an individual organism starting at y, settles at 
% x during a dispersal event. K is the dispersal kernel modeling the
% associated probabiility density
%D = diffusion coefficient associated with random movement
%alpha, beta = settling rate
%v = advective velocity (e.g. time dependent flow of theoretical river env)
%y = initial position
%x = end position
function disp_kernal_w_pop_dist_final
    while 1
        prompt = {'Enter diffusion coefficient: ', 'Enter settling rate: ', ...
            'Enter velocity: ', 'Length of bounded habitat: ', 'Number of generation: ',...
            'Name of Population Dist. file:' };
        dlg_title = 'Input Parameters';
        num_lines = 1;
        defaultans = {'.05','.8', '0', '2', '1', 'pop'};
        input = inputdlg(prompt, dlg_title, num_lines, defaultans);
    
        if isempty(input)
            return;
        end
        
        D = str2num(input{1});
        beta = str2num(input{2});
        v = str2num(input{3});
        L = str2num(input{4});
        gens = str2num(input{5});
        pop = str2func(input{6});
        z = -L/2.0:0.01:L/2.0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        f = figure;
        
        kernel = k(z, D, beta, v);
        subplot(3,1,1);
        plot(z, kernel, '-');
        xlabel('Position, x');
        ylabel('K(x,0)');
        title('Dispersal Kernal');
        
        %pop_dist = pop(D, beta, L);
        pop_dist = @(x) normpdf(x,0,1);
        subplot(3,1,2);
        fplot(pop_dist, [-L/2 L/2]);
        xlabel('Position, x');
        ylabel('n(x)');
        title('Initial Population Distribution');
        
        for m = 1:gens
            func = integral(@(x) k(z-x, D, beta, v) * pop_dist(x), -L/2, L/2, 'ArrayValued', true);
            %Calculate new population distribution
            pop_dist = @(x) interp1(z,func,x);
        end
        
        subplot(3,1,3);
        plot(z, func);
        xlabel('Position, x');
        y_str = sprintf('n(x) for t = %d', gens);
        ylabel(y_str);
        title('Population Distribution following Dispersal Event(s)');  
    end
end