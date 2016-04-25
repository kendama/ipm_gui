function ipm_gui2
% IPM_GUI2 User inputs selected parameters to define integrodifference 
% population model, then clicks the 'run' buttons. Clicking the button
% plots the resulting set of population distributions and the corresponding 
% asymptotic growth rate in the axes.

%  Create and then hide the UI as it is being constructed.
f = figure('Visible','off','Position',[500,500,1410,420]);


% Construct the components for inputs

%%%%%%%%%%%%%%%%Basic Input Parameters%%%%%%%%%%%%%%%%%%%%%
%bpan, dpan, and vpan used to define borders
bpan   = uipanel('Title', 'Basic Input Parameters','FontSize', 10,...
        'Position', [.009 .420 .1875 .560]);

%Diffusion coefficient
dtext = uicontrol('Style','text','String','Enter diffusion coefficient: ',...
           'Position',[20,370,160,15]);
diffcoef    = uicontrol('Style','edit',...
             'String','.05','Position',[180,370,70,20]);

         
%Settling rate
btext = uicontrol('Style','text','String','Enter settling rate: ',...
           'Position',[20,345,160,15]);
beta    = uicontrol('Style','edit',...
             'String','.8','Position',[180,345,70,20]);

         
%Bounded Habitat Length
ltext = uicontrol('Style','text','String','Length of bounded habitat: ',...
           'Position',[20,320,160,15]);
length = uicontrol('Style','edit',...
             'String','2','Position',[180,320,70,20]);

         
%Number of Generations
gtext = uicontrol('Style','text','String','Number of generation: ',...
           'Position',[20,295,160,15]);
gens = uicontrol('Style','edit',...
             'String','3','Position',[180,295,70,20]); 

         
%Initial Population Distribution
htext  = uicontrol('Style','text','String','Select Initial Dist. Model',...
           'Position',[50,265,180,15]);
hpopup = uicontrol('Style','popupmenu',...
           'String',{'Normal','Uniform','Patch'},...
           'Position',[50,235,100,25],...
           'Callback', {@popup_menu_Callback});

%Parameters for Normal Pop Distribution       
nortext  = uicontrol('Style','text','String','For Normal    -  ',...
           'Position',[15,202,80,15]);
nmtext  = uicontrol('Style','text','String','mu:',...
           'Position',[85,202,45,15]);
nmu = uicontrol('Style','edit',...
             'String','0','Position',[125,200,40,20]); 
nstext  = uicontrol('Style','text','String','sigma:',...
           'Position',[180,202,45,15]);
nsig = uicontrol('Style','edit',...
             'String','1','Position',[220,200,40,20]);

%%%%%%%%%%%%%%%%%%Growth Model Parameters%%%%%%%%%%%%%%%%%%%%%%
%Define borders 
dpan   = uipanel('Title', 'For Population Growth Models','FontSize', 10,...
        'Position', [.009 .070 .1875 .32]);

%Growth Model Selection
gmtext  = uicontrol('Style','text','String','Select Growth Model:',...
           'Position',[50,130,180,15]);
gmpopup = uicontrol('Style','popupmenu',...
           'String',{'Scalar','Beverton-Holt','Rickers'},...
           'Position',[50,100,150,25],...
           'Callback', {@growth_menu_Callback});

       
%Proliferation Rate
prtext = uicontrol('Style','text','String','Proliferation Rate (r): ',...
           'Position',[20,70,160,15]);
prolif = uicontrol('Style','edit',...
             'String','.6','Position',[180,70,70,20]);

         
%Carrying Capacity
cctext = uicontrol('Style','text','String','Carrying Capacity (K): ',...
           'Position',[20,45,160,15]);
carrcap = uicontrol('Style','edit',...
             'String','42','Position',[180,45,70,20]); 
         
%%%%%%%%%%%%%%%Velocity Parameters%%%%%%%%%%%%%%%%%%%       
%Define borders    
vpan   = uipanel('Title', 'Velocity Parameters','FontSize', 10,...
        'Position', [.800 .200 .19 .785]);

%Velocity
vtext = uicontrol('Style','text','String','Enter velocity: ',...
           'Position',[1135,370,160,15]);
velocity = uicontrol('Style','edit',...
             'String','0','Position',[1275,370,70,20]);

         
%Random Seed Checkbox
stext = uicontrol('Style','text','String','Check box to seed random velocity: ',...
           'Position',[1145,340,190,15]);
seed = uicontrol('Style','checkbox',...
             'Position',[1335,338,30,20]);

         
%Distributions for Random Number
rtext  = uicontrol('Style','text','String','Select Dist. for Random Number:',...
           'Position',[1150,310,180,15]);
rpopup = uicontrol('Style','popupmenu',...
           'String',{'Normal','Uniform','Lognormal'},...
           'Position',[1150,275,100,25],...
           'Callback', {@randv_menu_Callback});    

%%%%%%%%%%%%%%Random Number Parameters for Velocity%%%%%%%%%%%%%%%%%%%
%Parameters for uniformly distributed random values
utext = uicontrol('Style','text','String','Parameters for Uniform Distribution',...
           'Position',[1150,245,220,20]);

starttext = uicontrol('Style','text','String','a: ',...
           'Position',[1145,220,100,15]);
a    = uicontrol('Style','edit',...
             'String','0','Position',[1230,220,70,20]);

endtext = uicontrol('Style','text','String','b: ',...
           'Position',[1145,195,100,15]);
b    = uicontrol('Style','edit',...
             'String','1','Position',[1230,195,70,20]);
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameters for normal and lognormally distributed random values
lgtext = uicontrol('Style','text','String','Parameters for Normal/Lognormal Distribution',...
           'Position',[1150,155,225,25]);       
       
mtext = uicontrol('Style','text','String','Mu: ',...
           'Position',[1145,135,100,15]);
mew    = uicontrol('Style','edit',...
             'String','1.3','Position',[1230,135,70,20]);

      
%Sigma
sigtext = uicontrol('Style','text','String','Sigma: ',...
           'Position',[1145,110,100,15]);
sig    = uicontrol('Style','edit',...
             'String','2.6','Position',[1230,110,70,20]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Run button
run = uicontrol('Style', 'pushbutton', 'String', 'Run',...
            'Position',[1145,35,70,25],...
            'Callback', {@run_Callback});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%Axes for graph        
ha = axes('Units','pixels','Position',[345,95,330,265]);
hb = axes('Units','pixels','Position',[755,95,330,265]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Export buttons
exp1 = uicontrol('Style', 'pushbutton', 'String', 'Export',...
            'Position',[460,30,70,25],...
            'Callback', {@export1_Callback});

exp2 = uicontrol('Style', 'pushbutton', 'String', 'Export',...
            'Position',[880,30,70,25],...
            'Callback', {@export2_Callback});

        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

%Left side align
align([dtext,btext,ltext,gtext,prtext,cctext],'Left','None');
align([diffcoef,beta,length,gens,prolif,carrcap],'Center','None');
align([htext,hpopup,gmtext,gmpopup],'Center','None');

%Right side align
align([starttext,endtext,mtext,sigtext],'Left','None');
align(vtext,'Left','None');
align(stext,'Center','None');
align([velocity,a,b,mew,sig],'Center','None');
align([rtext,rpopup,utext,lgtext,run],'Center','None');

% Change units to normalized so components resize automatically.
f.Units = 'normalized';
ha.Units = 'normalized';
hb.Units = 'normalized';
dtext.Units = 'normalized';
btext.Units = 'normalized';
vtext.Units = 'normalized';
stext.Units = 'normalized';
ltext.Units = 'normalized';
gtext.Units = 'normalized';
rtext.Units = 'normalized';
mtext.Units = 'normalized';
sigtext.Units = 'normalized';
prtext.Units = 'normalized';
cctext.Units = 'normalized';
gmtext.Units = 'normalized';
diffcoef.Units = 'normalized';
beta.Units = 'normalized';
velocity.Units = 'normalized';
seed.Units = 'normalized';
length.Units = 'normalized';
gens.Units = 'normalized';
htext.Units = 'normalized';
hpopup.Units = 'normalized';
rpopup.Units = 'normalized';
gmpopup.Units = 'normalized';
mew.Units = 'normalized';
sig.Units = 'normalized';
prolif.Units = 'normalized';
carrcap.Units = 'normalized';
a.Units = 'normalized';
b.Units = 'normalized';
utext.Units = 'normalized';
lgtext.Units = 'normalized';
starttext.Units = 'normalized';
endtext.Units = 'normalized';
run.Units = 'normalized';
nortext.Units = 'normalized';
nmtext.Units = 'normalized';
nmu.Units = 'normalized';
nstext.Units = 'normalized';
nsig.Units = 'normalized';
exp1.Units = 'normalized';
exp2.Units = 'normalized';

%Define default initial population dist., growth model,
%and random seed w/ normal distribution
popN = 'normal';
growth = 'S';
randN = str2func('randn');


% Assign a name to appear in the window title.
f.Name = 'Population Modeling with Integrodifference Equations';

% Move the window to the center of the screen.
movegui(f,'center')

%Make the UI visible.
f.Visible = 'on';

%%%%%%%%%%%%% Callback Function Definitions %%%%%%%%%%%%%%%
    
    function popup_menu_Callback(source, eventdata) 
      % Define shape of the initial population distribution
      str = get(source, 'String');
      val = get(source,'Value');
      % Sets population distribution
      switch str{val};
      case 'Uniform' % User selects uniform distribution 
         popN = 'uniform';
      case 'Patch' % User selects patch-like distribution
         popN = 'patch'; 
         %for later deprecation w/ proper verbage
      case 'Normal' % User selects normal distribution
         popN = 'normal';
      end
    end
    
    function growth_menu_Callback(source, eventdata)
      % Determine the growth model.
      str = get(source, 'String');
      val = get(source,'Value');
      % Sets random number distribution
      switch str{val};
      case 'Beverton-Holt' % User selects Beverton-Holt growth model
         growth = 'BH';
      case 'Rickers' % User selects Rickers growth model
         growth = 'R';
      case 'Scalar' % User selects Scalar growth rate; R = r
         growth = 'S'; 
      end
    end

    function randv_menu_Callback(source, eventdata) 
      % Determine the selected value.
      str = get(source, 'String');
      val = get(source,'Value');
      % Sets random number distribution
      switch str{val};
      case 'Normal' % User selects normal distribution
         randN = str2func('randn');
      case 'Uniform' % User selects uniform distribution 
         randN = str2func('rand');
      case 'Lognormal' % User selects lognormal distribution
         randN = str2func('lognrnd');
      end
    end

    %When the user hits run, the following process will initiate
    
    function run_Callback(source,eventdata)
        %main function; simulates population dynamics
        tic;
        set(f, 'pointer', 'watch');
        drawnow;
        cla;
        
        diffc = get(diffcoef, 'String');
        beta_str = get(beta, 'String');
        vel = get(velocity, 'String');
        len = get(length, 'String');
        gens_str = get(gens, 'String');
        
        D = str2double(diffc);
        betaN = str2double(beta_str);
        L = str2double(len);
        gensN = str2double(gens_str);
        
        % Determine advection velocity
        checked = get(seed,'Value');
        %disp(checked)
        if checked == 1
            if isequal(randN, str2func('lognrnd'))
                
                muvs = get(mew,'String');
                muv = str2double(muvs);
                
                varvs = get(sig,'String');
                varv = str2double(varvs);
                
                mu = log((muv^2)/sqrt(varv+muv^2));
                sigma = sqrt(log(varv/(muv^2)+1));
                [M,V]= lognstat(mu,sigma);
                vel = lognrnd(mu,sigma,1,gensN);
                
            else
                vel = randN(1,gensN);
            end
        else
            vel = str2double(vel);
        end
        
        z = -L/2.0:0.01:L/2.0;
        lambda = zeros(1,gensN);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        if strcmp(popN, 'uniform')
            popdist = @(x) unifpdf(z,-L,L);
           
        elseif strcmp(popN, 'patch')
            pdP = makedist('Uniform','lower',-L/4.0,'upper',L/4.0);
            popdist = @(x) pdf(pdP,z); %make variable with unifpdf
            
        elseif strcmp(popN, 'normal')
            mu_str = get(nmu,'String');
            sig_str = get(nsig,'String');
            muD = str2double(mu_str);
            sigD = str2double(sig_str);
            popdist = @(x) normpdf(x,muD,sigD);
        end

        %Determine growth function
        if strcmp(growth,'S')
            r = get(prolif, 'String');
            R = str2double(r);
        else
            rS = get(prolif, 'String');
            KS = get(carrcap, 'String');
            r = str2double(rS);
            K = str2double(KS);
            if strcmp(growth,'BH')
                R = @(x) r./(1 + ((r - 1) .* popdist(x)/K));    
            elseif strcmp(growth,'R')
                R = @(x) exp(r .* (1 - popdist(x)/K));
            end
        end   
                
        % Main loop        
        for m = 1:gensN
            if checked == 1
                v = vel(m);
            else
                v = vel;
            end
            if isnumeric(R)
                func = integral(@(x) k(z-x, D, betaN, v) * R .* popdist(x), -L/2, L/2, ... 
                'ArrayValued', true);
            else
                func = integral(@(x) k(z-x, D, betaN, v) .* R(x) .* popdist(x), -L/2, L/2, ... 
                'ArrayValued', true);
            end
            %Plot the population distribution for the given generation
            plot(hb, z, func);
            hold on
            %Calculate new population distribution
            popdist = @(x) interp1(z,func,x);
            n_value = integral(popdist, -L/2, L/2);
            lambda(m) = n_value^(1/m);
        end
        
        %Plotting in GUI
        xlabel(hb, 'Position, x');
        y_str = sprintf('n(x) for t = %d', gensN);
        ylabel(hb, y_str);
        title_str = sprintf('Population Distribution at %d', gensN);
        title(hb, title_str);
        hold off 
        
        plot(ha, 1:1:gensN, lambda, '+', gensN, lambda(gensN), '+');
        xlabel(ha, 'Time, t');
        y_str = sprintf('Lambda for t = %d', gensN);
        ylabel(ha, y_str);
        LEG = legend(ha, sprintf('Lambda = %0.8f', lambda(gensN)));
        title(ha, 'Asymptotic Growth Rate');
        set(LEG, 'FontSize', 11);
        set(f, 'pointer', 'arrow');
        toc;
    end

    function export1_Callback(source,eventdata)
        %export ha axes to new figure
        fig4exp1 = figure;
        copyobj(ha,fig4exp1);
        haRef = gca;
        set(haRef, 'OuterPosition', [.075, .075, .85, .85]);
        
        %hgsave(fig4exp1,'Asymptotic Growth Rate');
    end

    function export2_Callback(source,eventdata)
        %export hb axes to new figure
        fig4exp2 = figure;
        copyobj(hb,fig4exp2);
        hbRef = gca;
        set(hbRef, 'OuterPosition', [.075, .075, .85, .85]);
        
        %hgsave(fig4exp1,'Population Distribution at %s', gens_str);
    end

end