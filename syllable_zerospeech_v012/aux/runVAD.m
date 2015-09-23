function vadmasks = runVAD(F,fs,corpus)
%function vadmasks = runVAD(F,fs,corpus)
%
% Simulates voice-activity detection (VAD) by simply using the evaluation
% intervals provided by the zerospeech-challenge.
%
% Inputs:  
%
%   F       : features for each signal (Mx1 cell array).
%   fs      : sampling rate of the features
%   corpus  : which zerospeech corpus? ('eng' or 'tsonga')
%
% Outputs:
%
%   vadmasks: cell-array of VAD masks for each signal (1 == speech, 0 =
%               no-speech). Mx1 cell array.

if nargin <2
    fs = 100;
end

if nargin <3
    corpus = 'eng';
end

% Load evalution intervals
if(strcmp(corpus,'eng'))
    [signname_eva,onset_eva,offset_eva] = textread('english.split','%s %f %f','delimiter',' ');
elseif(strcmp(corpus,'tsonga'))
    [signname_eva,onset_eva,offset_eva] = textread('xitsonga.split','%s %f %f','delimiter',' ');
else
    error('unknown corpus');
end    

all_signalnames = unique(signname_eva);

% Gather split information into arrays specific to each signal to speed up
% computations

all_bounds = [onset_eva offset_eva];

B = cell(length(F),1);
for k = 1:length(F)
    B{k} = all_bounds(strcmp(signname_eva,all_signalnames{k}),:);    
end

% Get valid segments for each signal 
vadmasks = cell(length(F),1);
for k = 1:length(F)
    vadmasks{k} = zeros(length(F{k}),1);
    for j = 1:size(B{k},1)
        vadmasks{k}(round(B{k}(j,1)*fs)+1:round(B{k}(j,2)*fs)) = 1;
    end  
end
