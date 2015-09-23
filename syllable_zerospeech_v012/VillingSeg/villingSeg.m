function bounds = villingSeg(signal,fs)
% function bounds = villingSeg(signal,fs)
%
% Performs envelope-based syllabification using the algoritmh described in
% Villing, Timoney, Ward & Costello (2004) while using the modifications 
% implemented in AuToBI-toolbox by Rosenberg (2010). 
% 
% Inputs:   
%       signal:     signal waveform
%       fs:         signal sampling rate (default 16000 Hz)
%
% Outputs:
%       bounds:     segment boundaries (in seconds)
%

if nargin <2
    fs = 16000;
end

if(fs~=16000)
   signal =  resample(signal,16000,fs);   
end

% Parameters (these defaults from Villing et al. (2014) and Rosenberg, 2010)
% seem to work relatively well at least for English and Tsonga)

bmin = 0.01;
bmax = 0.1;

%cmin = 0.85; % Not used in AuToBI 
%cmax = 0.97;

vpmin = 0.01;      
vpmax = 0.1;

smin = 0.6;
smax = 0.7;

% Equal loudness filtering according to ReplayGain-specifications

signal = replayGain(signal,16000);

% Design second order Butterworth lowpass filter with 1 kHz cut-off
[b1,a1] = butter(2,1/16);

env1 = filter(b1,a1,signal); % < 1 kHz envelope

env3 = signal;                % Full-band envelope

env1 = abs(env1);       % Full wave rectification
env3 = abs(env3);

% Low-pass envelopes at 12 Hz by filtering in both directions (zero phase
% shift)
[b_lp,a_lp] = butter(1,12/16000); 

env1 = filtfilt(b_lp,a_lp,env1);

env3 = filtfilt(b_lp,a_lp,env3);

% Downsample to 100 Hz
env1 = resample(env1,1,160);

env3 = resample(env3,1,160);

% Loudness normalization
env1 = env1.^0.3;
env3 = env3.^0.3;

% Onset velocity from full-band envelope

vel = diff(env3);

% Half-wave rectification

vel(vel < 0) = 0;

% Normalize low-band envelope 

env1 = env1./env3;


% Find all velocity peaks and their onset/offset times.

os = zeros(10000,1);
op = zeros(10000,1);
oe = zeros(10000,1);
n = 1;
onset = 0;
offset = 1;

for j = 1:length(vel)-1    
    
    if(vel(j) > 0 && onset == 0 && offset == 1)
        os(n) = j;
        onset = 1;
        offset = 0;        
        maxval = vel(j);
        op(n) = j;
    elseif(onset == 1 && vel(j) > maxval)
         maxval = vel(j);
         op(n) = j;
    elseif(onset == 1 && vel(j) == 0)
        offset = 1;
        onset = 0;
        oe(n) = j-1;                
        n = n+1;
    end    
end

os = os(1:n-1);
op = op(1:n-1);
oe = oe(1:n-1);

% Boundary scoring

bs = VillingScore(vel,op,bmin,bmax); % Boundary scores

ss = VillingScore(env1,oe,smin,smax);  

%cs = VillingScore(env1,oe,cmin,cmax); % not used in AuToBI

vps = VillingScore(vel,op,vpmin,vpmax);

%vs = ss.*(1-cs).*vps;              % This is used in original paper,
vs = ss.*vps;                       % AuToBI variant

% If there's a major peak (vs == 1), then supress others within 100 ms to
% a negative value 

peak_frames = find(vs == 1);
for j = 1:length(peak_frames)    
    dist_prev = op(peak_frames(j))-op(peak_frames(j)-...
        (1:min(10,peak_frames(j)-1)));
    
    
    inds_prev = peak_frames(j)-1:-1:peak_frames(j)-length(dist_prev);
    vals_prev = vs(inds_prev);
    
    dist_next = abs(op(peak_frames(j))-op(peak_frames(j)+...
        (1:min(10,length(op)-peak_frames(j)))));
    
    inds_next = peak_frames(j)+1:1:peak_frames(j)+length(dist_next);
    vals_next = vs(inds_next);
    
    b = find(vals_prev < 1);
    c = find(dist_prev < 100);
    b = intersect(b,c);
    vs(inds_prev(b)) = -1;
    b = find(vals_next < 1);
    c = find(dist_next < 100);
    b = intersect(b,c);
    vs(inds_next(b)) = -1;        
end

% Select boundaries

bestval = 0;
trough = [];
bb = [];
bounds = [];

for k = 1:length(bs)
   if(~isempty(bb))     
       if(bs(k) > bestval && env3(oe(k)) < trough)
          bb = k; 
          trough = env3(oe(k));
          bestval = bs(k);
       end       
   else
       bb = k;
       bestval = bs(k);
       trough= env3(oe(k));
   end
   if(vs(k) > 0)
       bounds = [bounds;os(bb)];
       bb = [];
       trough = 0;
       bestval = 0;
   end
end

% Convert to seconds
bounds = bounds./100;
