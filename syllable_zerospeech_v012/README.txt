Matlab-scripts for running syllable-based word learning for Zero Resource Speech Challenge of Interspeech'2015.

v 0.12, last update: 23.9.2015

(c) Okko Rasanen, okko.rasanen@aalto.fi


Version notes:
——
0.12 Fixed a bug in croptointervals.m that led to less final segment outputs than intended  (thanks to Oliver Walter). This fix increases word discovery F-scores in the English zero-speech task due to the increased recall. 

0.11 The original public release.


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

