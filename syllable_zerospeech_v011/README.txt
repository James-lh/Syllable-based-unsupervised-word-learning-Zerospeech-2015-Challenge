Matlab-scripts for running syllable-based word learning for Zero Resource Speech Challenge of Interspeech'2015.

v 0.11, last update: 23.3.2015

(c) Okko Rasanen, okko.rasanen@aalto.fi

----
Please cite the following paper if you make public use of these codes:
O. Rasanen, G. Doyle & M.C. Frank: "Unsupervised word discovery from 
speech using automatic segmentation into syllable-like units," submitted to 
Interspeech-2015, Dresden, Germany, 2015.

See the above paper for a technical description of the system.

----
To get started:

1) Add the main folder (the one where this README.txt resides) and all its sub-folders to Matlab path definitions

2) Edit path in the beginning of runSyllablePD_English.m (runSyllablePD_Tsonga.m) to point to your audio file directory. 

3) Run runSyllablePD_English.m (runSyllablePD_Tsonga.m). 

——
The processing pipelines for English and Tsonga data sets are otherwise the same except for some corpus-specific data-handling functions. 

