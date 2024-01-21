folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
all_dirs = all_objects([all_objects.isdir]==0);

for c = 1:size(all_objects)
    dirName = all_objects(c).name;
    spk_id = extractBefore(dirName,'ch');

    [audioData, sampleRate] = audioread(fullfile(folderpath,all_objects(c).name));
    % Apply absolute scaling 
    normalizer = max(abs(audioData));
    scaledAudioData = audioData / normalizer;
    

    audiowrite(['Absolute_scaled\' spk_id 'abs_scaled.wav'],scaledAudioData, sampleRate);
end