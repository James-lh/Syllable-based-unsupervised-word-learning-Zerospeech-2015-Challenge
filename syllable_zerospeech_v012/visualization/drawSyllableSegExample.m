function drawSyllableSegExample(original_audio,bounds,envelopes)


set(0, 'DefaultAxesFontSize',16) 
timeinds = 47000:53000;
t_env = timeinds./1000;

figure;
subplot(2,1,1);
audio_onset = t_env(1)*16000;
audio_offset = t_env(end)*16000;
t_aud = t_env(1):1/16000:t_env(end);



plot(t_aud,original_audio{1}(audio_onset:audio_offset));hold on;
a = find(bounds{1} > timeinds(1));
b = find(bounds{1} < timeinds(end));
c = intersect(a,b);
bb = bounds{1}(c);
for k = 1:length(bb)
   line([bb(k)./1000 bb(k)./1000],[-1 1],'Color','red'); 
end
ylim([min(original_audio{1}(audio_onset:audio_offset)) max(original_audio{1}(audio_onset:audio_offset))]);
ylabel('amplitude');
xlim([47.31 52.24]);
subplot(2,1,2);
plot(t_env,envelopes{1}(timeinds(1):timeinds(end)),'LineWidth',1);hold on;
a = find(bounds{1} > timeinds(1));
b = find(bounds{1} < timeinds(end));
c = intersect(a,b);
bb = bounds{1}(c);
for k = 1:length(bb)
   line([bb(k)./1000 bb(k)./1000],[0 1],'Color','red'); 
end
xlabel('time (s)');
ylim([0 0.5])
xlim([47.31 52.24]);
ylabel('amplitude');