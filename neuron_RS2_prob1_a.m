%   This MATLAB file generates figure 1 in the paper by 
%               Izhikevich E.M. (2004) 
%   Which Model to Use For Cortical Spiking Neurons? 
%   use MATLAB R13 or later. November 2003. San Diego, CA 

%   Modified by Ali Minai


%%%%%%%%%%%%%%% regular spiking %%%%%%%%%%%%%%%%%%%%%% 

steps = 1000;                  %This simulation runs for 1000 steps

a=0.02; b=0.25; c=-65;  d=6;
V=-64; u=b*V;
VV=[];  uu=[];
tau = 1; %0.25; % for convenience
tspan = 0:tau:steps;  %tau is the discretization time-step
                                  %tspan is the simulation interval
                                
T1=50;            %T1 is the time at which the step input rises

spike_ts = [];

v_matrix = [];
i = 1;
I_values = [1, 5, 10, 15, 20];

for I = I_values
     
    for t=tspan
        
        V = V + tau*(0.04*V^2+5*V+140-u+I);
        u = u + tau*a*(b*V-u);
        
        if V > 30                 %if this is a spike
            VV(end+1)=30;         %VV is the time-series of membrane potentials
            V = c;
            u = u + d;
            spike_ts = [spike_ts ; 1];   %records a spike
        else
            VV(end+1)=V;
            spike_ts = [spike_ts ; 0];   %records no spike
        end;
        uu(end+1)=u;
        
    end;
    

    v_matrix(end + 1, : ) = VV;
    
    % reset arrays
    spike_ts = [];
    uu = [];
    VV = [];
    
    i = i + 1;
    
end



for k = 1:5
    
    subplot(5,1,k)
    plot(tspan,v_matrix(k,:));
    axis([0 max(tspan) -90 40])
    xlabel('time step');
    ylabel('V_m')
    title(['Figure 1' char(k+64) ', '  'I = ' num2str( I_values(k))])
    
end

% subplot(2,1,1)
% plot(tspan,VV);                   %VV is plotted as the output
% axis([0 max(tspan) -90 40])
% xlabel('time step');
% ylabel('V_m')
% %xticks([0 max(tspan)]);
% %xticklabels([0 steps]);
% title('Regular Spiking');

%subplot(2,1,2)
%plot(tspan,spike_ts,'r');                   %spike train is plotted
%axis([0 max(tspan) 0 1.5])
%xlabel('time step');
%xticks([0 max(tspan)]);
%xticklabels([0 steps]);
%yticks([0 1]); 





