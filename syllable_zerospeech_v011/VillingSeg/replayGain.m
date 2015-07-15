function y= replayGain(x,fs_orig)
%function y= replayGain(x,fs_orig)
%
% Performs loudness normalization across signal frequencies according to
% ReplayGain specifications.
%
% Note:
% This code is extracted and slightly modified from: 
% http://replaygain.hydrogenaud.io/proposal/equal_loudness.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trying to design a filter to match equal loudness curves
% David Robinson http://www.David.Robinson.org 10/07/2001

% This script draws some of the graphs on the following web page:
% http://www.David.Robinson.org/replaygain/equal_loudness.html

if(fs_orig ~= 48000)
    x = resample(x,48000,fs_orig);
end

% Set sampling rate
fs=48000;

% Specify Equal Loudness amplitude response

EL80=[0,120;20,113;30,103;40,97;50,93;60,91;70,89;80,87;90,86;100,85;200,78;300,76;400,76;500,76;600,76;700,77;800,78;900,79.5;1000,80;1500,79;2000,77;2500,74;3000,71.5;3700,70;4000,70.5;5000,74;6000,79;7000,84;8000,86;9000,86;10000,85;12000,95;15000,110;20000,125;fs/2,140];

% Generate an impulse to filter in order to yield the long-term impulse response of each filter
a = x;

% Convert target frequency and amplitude data into format suitable for yulewalk function
f=EL80(:,1)./(fs/2);
m=10.^((70-EL80(:,2))/20);

% Design a 10 coefficient filter using "yulewalk" function
[By,Ay]=yulewalk(10,f,m);
c=filter(By,Ay,a);

% Plot frequency response of yulewalk IIR filter design

% Design a 2nd order Butterwork high-pass filter using "butter" function
[Bb,Ab]=butter(2,(150/(fs/2)),'high');


e=filter(Bb,Ab,c);

% Downsample to original sampling rate
y = resample(e,fs_orig,48000);

