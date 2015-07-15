function signal_names = convertSignNames(signal_numbers)
% function signal_names = convertSignNames(signal_numbers)
% Converts signal numbers into signal names
%
%

if(max(signal_numbers) < 69)
    load signalnames.mat 
else
    load signalnames_tsonga.mat 
end

signal_names = cell(size(signal_numbers));

for k = 1:length(signal_numbers)
    signal_names{k} = all_signalnames{signal_numbers(k)};    
end

