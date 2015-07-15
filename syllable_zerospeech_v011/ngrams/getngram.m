 function ngram = getngram(loc,alphsize)

% Get number of numbers
alphsize = alphsize+1;

N = ceil(log(loc)/log(alphsize));

res = loc;
ngram = zeros(1,N);
for j = 1:N

    ngram(j) = ceil((res-alphsize^(N-j))/alphsize^(N-j));
    ngram(j) = round(ngram(j));
    res = res-ngram(j)*alphsize^(N-j);

end

ngram(j) = ngram(j)+1;


