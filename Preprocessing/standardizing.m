folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
all_dirs = all_objects([all_objects.isdir]==0);

for c = 1:size(all_objects)
    dirName = all_objects(c).name;
    spk_id = extractBefore(dirName,'ch');

    [audioData, sampleRate] = audioread(fullfile(folderpath,all_objects(c).name));
    % Apply standard scaling using zscore function
    scaledAudioData = zscore(audioData);
    

    audiowrite(['Standardized\' spk_id 'standardized.wav'],scaledAudioData, sampleRate);
end