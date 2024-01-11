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
