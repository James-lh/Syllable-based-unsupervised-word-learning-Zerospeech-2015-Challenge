function [times_eva,classes_eva,signal_names_eva] = removeShorts(times_eva,classes_eva,signal_names_eva,minlen)

dur = times_eva(:,2)-times_eva(:,1);

a = find(dur < minlen);
times_eva(a,:) = [];
classes_eva(a) = [];
signal_names_eva(a) = [];
