function [times_eva,classes_eva,signal_names_eva] = removeSingles(times_eva,classes_eva,signal_names_eva)

count = histc(classes_eva,1:max(classes_eva));

a = find(count == 1);

for j = 1:length(a)
    b = find(classes_eva == a(j));

times_eva(b,:) = [];
signal_names_eva(b) = [];
classes_eva(b) = [];
end