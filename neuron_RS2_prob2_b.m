% Problem 2 b
steps = 1000;                  %This simulation runs for 1000 steps

a=0.02; b=0.25; c=-65;  d=6;

%V
V_A=-64;
V_B=-64;
V_C=-64;

% u
u_A=b*V_A;
u_B=b*V_B;
u_C=b*V_C;

% VV
VV_A=[];
VV_B=[];
VV_C=[];

% uu
uu_A=[];
uu_B=[];
uu_C=[];

tau = .25; %0.25; % for convenience
tspan = 0:tau:steps;  %tau is the discretization time-step
                                  %tspan is the simulation interval
                                
T1=50;            %T1 is the time at which the step input rises

%spike_ts
spike_ts_A = [];
spike_ts_B = [];
spike_ts_C = [];

%Storage matrix for voltage values
v_matrix_A = [];
v_matrix_B = [];
v_matrix_C = [];

% weight values  
w_values = [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150];

% fixed Ia and Ib values
I_A = 5;
I_B = 15;
I_C =0;

R = []; % mean spike rate

for w = w_values
    
    %V
    V_A=-64;
    V_B=-64;
    V_C=-64;
    
    % u
    u_A=b*V_A;
    u_B=b*V_B;
    u_C=b*V_C;

    
    for t=tspan
        
        %Neuron A
        V_A = V_A + tau*(0.04*V_A^2+5*V_A+140-u_A+I_A);
        u_A = u_A + tau*a*(b*V_A-u_A);
        
        if V_A > 30                 %if this is a spike
            VV_A(end+1)=30;         %VV_A is the time-series of membrane potentials
            V_A = c;
            u_A = u_A + d;
            spike_ts_A = [spike_ts_A ; 1];   %records a spike
            
        else
            VV_A(end+1)=V_A;
            spike_ts_A = [spike_ts_A ; 0];   %records no spike
            
        end;
        uu_A(end+1)=u_A;
        
        
        
        % Neuron B
        V_B = V_B + tau*(0.04*V_B^2+5*V_B+140-u_B+I_B);
        u_B = u_B + tau*a*(b*V_B-u_B);
        
        if V_B > 30                 %if this is a spike
            VV_B(end+1)=30;         %VV_B is the time-series of membrane potentials
            V_B = c;
            u_B = u_B + d;
            spike_ts_B = [spike_ts_B ; 1];   %records a spike
            
        else
            VV_B(end+1)=V_B;
            spike_ts_B = [spike_ts_B ; 0];   %records no spike
            
        end;
        uu_B(end+1)=u_B;
        
        
        % Neuron C
        
        %I_C = w*A_bool + w*B_bool;
        I_C = w*spike_ts_A(end) + w*spike_ts_B(end);
        
        V_C = V_C + tau*(0.04*V_C^2+5*V_C+140-u_C+I_C);
        u_C = u_C + tau*a*(b*V_C-u_C);
        
        if V_C > 30                 %if this is a spike
            VV_C(end+1)=30;         %VV_C is the time-series of membrane potentials
            V_C = c;
            u_C = u_C + d;
            spike_ts_C = [spike_ts_C ; 1];   %records a spike
        else
            VV_C(end+1)=V_C;
            spike_ts_C = [spike_ts_C ; 0];   %records no spike
        end;
        uu_C(end+1)=u_C;

        
        
    end;
    
    
    v_matrix_A(end + 1, : ) = VV_A;
    v_matrix_B(end + 1, : ) = VV_B;
    v_matrix_C(end + 1, : ) = VV_C;
    
    
    % reset arrays
    spike_ts_A = [];
    spike_ts_B = [];
    spike_ts_C = [];

    uu_A = [];
    uu_B = [];
    uu_C = [];
    
    VV_A = [];
    VV_B = [];
    VV_C = [];
    
    
    
end


x = 1:800;


for k = 1:11
    
    figure(k)
    
    subplot(3,1,1)
    plot(x, v_matrix_A(k,3201:4000), 'b-');
    axis([0 800 -90 40])
    set(gca,'XTickLabel',800:25:1000);
    title(['Neuron A' char(k+64) ', '  'w = ' num2str( w_values(k))])
    
    subplot(3,1,2)
    plot(x, v_matrix_B(k,3201:4000), 'g-');
    axis([0 800 -90 40])
    set(gca,'XTickLabel',800:25:1000);
    title(['Neuron B' char(k+64) ', '  'w = ' num2str( w_values(k))])
    
    subplot(3,1,3)
    plot(x, v_matrix_C(k,3201:4000), 'r-');
    axis([0 800 -90 40])
    set(gca,'XTickLabel',800:25:1000);
    title(['Neuron C' char(k+64) ', with '  'w = ' num2str( w_values(k))])
    
end















