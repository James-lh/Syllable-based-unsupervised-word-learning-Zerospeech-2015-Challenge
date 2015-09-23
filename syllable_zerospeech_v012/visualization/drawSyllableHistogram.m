function drawSyllableHistogram(bounds_t)

set(0, 'DefaultAxesFontSize',16) 
btot = [];

for k = 1:length(bounds_t)
   btot = [btot;bounds_t{k}]; 
end

bdiff = diff(btot);

bdiff(bdiff > 1) = [];
bdiff(bdiff < 0) = [];
figure;hist(bdiff,75);
xlabel('duration (s)');
ylabel('count');
grid;