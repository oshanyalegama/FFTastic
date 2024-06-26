# FFTastic

# DataAugmentation

SplitSamples.m can be used to split the samples of a given channel into the relevant speaker clips once the timing data is given. When using,
  1. Make sure you are in the correct folder with the samples folder.
  2. Edit the code to choose the channel you wish (the given code is for channel 05).
  3. Create a folder called NewSamples where the new audio clips will be saved.
  4. https://dms.uom.lk/s/6qyqRtDwETC9rx9 

AddNoise.m is used to add noise to the enrollment audio files, ChangeVolume.m is used to change the volume of the enrollment audio files. When using,
  1. Make sure you are in the correct folder.
  2. The number of augmented samples, probability and range can be adjusted.
  3. Create a folder called NoiseSamples, VolumeSamples where the new audio clips will be saved.
  4. NoiseSamples: https://dms.uom.lk/s/nCpx9jnpqS8L6pA 
  5. VolumeSamples: https://dms.uom.lk/s/RdkL8ZfZkFgxbcX 

AddReverberation.m can be used to add reverberation to the audio files. When using,
  1. The number preceding the 'WetDryMix' indicates the reveberation to original sound ratio.
  2. https://dms.uom.lk/s/nEoeNKEiBmW6xqB 

BabbleGenerator.m can be used to generate babble samples using the enrollment clips. When using,
  1. The number of babble clips and the number of enrollment clips in a single babble clip can be adjusted.
  2. https://dms.uom.lk/s/eL7LWHzkx7YiHNj

AddBabble.m will combine the babble clips and the enrollment clips to give a new dataset. When using,
  1. Ensure that the number of babble clips and enrollment clips are equal. (Generate the babble clips using enrollment clips with BabbleGenerator.m)
  2. https://dms.uom.lk/s/9eKHn7f5E273oqR

Additional Dataset for french speech recognition and speaker verification.
  1. https://openslr.org/88/


# Signal Enhancement

Filter.m contains code for both denoising and filtering. Adjust the filter passband and stopband edges as required. If needed to convert to Hz, multiply the value by sampling_frequency/2 (in this case 16000/2 =8000)

Looped codes can be used on any folder to filter/ denoise all files in the code.

The Amplify codes in addition to denoising, amplify the signal 2x for clearer hearing.

# Model

1. KNN is a K means clustering method of speaker verification based on extracting features. The test has done been to the enrollment set only. It is suggested to try this for an expanded enrollment set and for the test set.

2. ivector based system implementation in MATLAB. A baseline system that generates the submission file as well.

3. A model based on extracting the embedding using an LSTM network

4. The TitaNet-L model by NVidia

## More details can be found in the final report.
