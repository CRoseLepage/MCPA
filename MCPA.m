function MCPA(initialX, initialV, numLoops)
%MCPA Simulates random electron scattering through a medium
%   

%Setup initial system constraints, using user input if available
system.force = 1E-31; %kg*m/s^2
system.deltaT = 1E-6;
system.totalT = 0;
electron.m = 1.109E-31; %kg

if(nargin < 2)
    electron.x = 0; %m
    electron.v = 0; %m/s
else
    electron.x = initialX; 
    electron.v = initialV;
end

ForceMratio = system.force./electron.m;

%Setup initial plot
figure(1)
xGraph = subplot(2,1,1);
plot(xGraph, electron.x, system.totalT);
xGraph = title('Position vs. Time of Randomly Scattering Electron', 'Interpreter', 'Latex');
xGraph = xlabel('Time (s)', 'Interpreter', 'Latex');
xGraph = ylabel('Position (m)', 'Interpreter', 'Latex');
hold on
vGraph = subplot(2,1,2);
vGraph = plot(electron.v, system.totalT);
vGraph = title('Velocity vs. Time of Randomly Scattering Electron', 'Interpreter', 'Latex');
vGraph = xlabel('Time (s)', 'Interpreter', 'Latex');
vGraph = ylabel('Velocity ($\frac{m}{s}$)', 'Interpreter', 'Latex');
hold on


%Calculate new velocity and position From F = ma
for i = 1:numLoops
    system.totalT = system.totalT + system.deltaT;
    
    electron.x = electron.x + ForceMratio.*system.deltaT.^2;
    electron.v = electron.v + ForceMratio.*system.deltaT;
    
    plot(xGraph, electron.x, system.totalT);
    plot(vGraph, electron.v, system.totalT);
   
end


