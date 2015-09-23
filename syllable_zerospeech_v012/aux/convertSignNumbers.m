function signal_numbers = convertSignNumbers(signal_names)
% function signal_names = convertSignNames(signal_numbers)
% Converts signal numbers into signal names
%
%

if(length(signal_names{1}) > 18)
    load signalnames_tsonga.mat     
else
    load signalnames.mat     
end


signal_numbers = zeros(size(signal_names));

for k = 1:length(signal_names)
    signal_numbers(k) = find(strcmp(all_signalnames,signal_names{k}));    
end

