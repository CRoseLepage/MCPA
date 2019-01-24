function MCPA(length, numLoops)
%MCPA Simulates random electron scattering through a medium
%   
clc 
close all
%Setup initial system constraints, using user input if available
system.force = 0.5E-31; %kg*m/s^2
system.deltaT = 1E-6;
system.totalT = 0;
electron.m = 1.109E-31; %kg

electron.x = zeros(1,length); %m
electron.v = zeros(1,length); %m/s
electron.driftv = zeros(1,length);


ForceMratio = system.force./electron.m;

%Setup initial plot
figure(1)
xGraph = subplot(2,1,1);
plot(xGraph, electron.x, system.totalT);
xGraphTitle = title('Position vs. Time of Randomly Scattering Electron', 'Interpreter', 'Latex');
xGraphXlabel = xlabel('Time (s)', 'Interpreter', 'Latex');
xGraphYlabel = ylabel('Position (m)', 'Interpreter', 'Latex');
hold on
vGraph = subplot(2,1,2);
plot(electron.v, system.totalT);
vGraphTitle = title('Velocity vs. Time of Randomly Scattering Electron, v = ', 'Interpreter', 'Latex');
vGraphXlabel = xlabel('Time (s)', 'Interpreter', 'Latex');
vGraphYlabel = ylabel('Velocity ($\frac{m}{s}$)', 'Interpreter', 'Latex');
hold on


%Calculate new velocity and position From F = ma
for i = 1:numLoops
    for j = 1:length
        system.totalT = system.totalT + system.deltaT;

        electron.x(j) = electron.x(j) + electron.v(j).*system.deltaT;
        electron.v(j) = electron.v(j) + ForceMratio.*system.deltaT;

        if(j == 1)
            plot(xGraph, system.totalT,electron.x(1), 'r.');
            hold on
            plot(vGraph, system.totalT,electron.v(1), 'b.');
            hold on
            title(['Velocity vs. Time of Randomly Scattering Electron, v =' num2str(mean(electron.x(1)/system.totalT))], 'Interpreter', 'Latex');
        end

        if (rand()>0.95)
            electron.v(j)=0;
        end
    end
    if mod(numLoops, 100) == 0
        fprintf('%i \n', i);
    end
    pause(0.01);
end
for i=1:length
   electron.driftv(i) = electron.x(i)/system.totalT; 
end

title(['Velocity vs. Time of Randomly Scattering Electron, v =' num2str(mean(electron.driftv))], 'Interpreter', 'Latex');

fprintf('Done \n');

