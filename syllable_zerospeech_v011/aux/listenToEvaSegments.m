function recording = listenToEvaSegments(signal_names,bounds,classes,data_train,record,orderi)
% function recording = listenToEvaSegments(signal_names,bounds,classes,data_train,record,orderi)


if nargin <5
    record = 0;
end

if nargin <6 
    orderi = 1:max(classes);
end

if(isempty(orderi))
   orderi = 1:max(classes); 
end


signal_numbers = convertSignNumbers(signal_names);

t = 0:1/24000:0.5;
t = t';

unique_classes = max(classes);
recording = [];
for k = 1:max(classes)
    if(k <= length(orderi))
    fprintf('Class %d.\n',orderi(k));
    a = find(classes == orderi(k));
    
    for j = 1:length(a)
        
        
        if(bounds(a(j),2)-bounds(a(j),1) < 2)
        
        [x,fs] = wavread(data_train{signal_numbers(a(j))});        
        
        if(record == 1)
            tmp = x(bounds(a(j),1)*fs:bounds(a(j),2)*fs);
            tmp = tmp./max(tmp);
           recording = [recording;tmp;zeros(0.5*fs,1)]; 
           
        else
            soundsc(x(bounds(a(j),1)*fs:bounds(a(j),2)*fs),fs);        
        end
        end
        
    end
    if(~record && ~isempty(a))
    pause;    
    elseif(~isempty(a))
        recording = [recording;sin(2.*pi*500.*t);zeros(0.5*fs,1)];
    end
    end
end