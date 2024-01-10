# FFTastic

# DataAugmentation

SplitSamples.m can be used to split the samples of a given channel into the relevant speaker clips once the timing data is given. When using,
  1. Make sure you are in the correct folder with the samples folder.
  2. Edit the code to choose the channel you wish (the given code is for channel 05).
  3. Create a folder called NewSamples where the new audio clips will be saved.

AddNoise.m is used to add noise to the enrollment audio files, ChangeVolume.m is used to change the volume of the enrollment audio files. When using,
  1. Make sure you are in the correct folder.
  2. The number of augmented samples, probability and range can be adjusted.
  3. Create a folder called NoiseSamples, VolumeSamples where the new audio clips will be saved.
