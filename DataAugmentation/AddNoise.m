augmenter = audioDataAugmenter( ...
    "AugmentationMode","sequential", ...
    "NumAugmentations",2, ... %Change the number of Augmented output samples
    ...
    "TimeStretchProbability",0, ...
    ...
    "PitchShiftProbability",0, ...
    ...
    "VolumeControlProbability",0, ...
    ...
    "AddNoiseProbability",1, ... %Change the probability of adding noise
    "SNRRange",[5,15],... %Change the noise range
    ...
    "TimeShiftProbability",0);

folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
all_dirs = all_objects([all_objects.isdir]==0);

for c = 1:size(all_objects)
    dirName = all_objects(c).name;
    spk_id = extractBefore(dirName,'ch');

    [x,fs] = audioread(fullfile(folderpath,all_objects(c).name));
    data = augment(augmenter,x,fs);

    for i=1:2    
        augmentationToInspect = data.Audio{i,1};
        audiowrite(['NoiseSamples\' spk_id 'n' num2str(i) '.wav'],augmentationToInspect, fs)
        %soundsc(augmentationToInspect,fs)
    end
end

