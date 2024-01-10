folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
all_dirs = all_objects([all_objects.isdir]==0);

for c = 1:size(all_objects)
    dirName = all_objects(c).name;
    spk_id = extractBefore(dirName,'ch');

    [x,fs] = audioread(fullfile(folderpath,all_objects(c).name));
    reverb = reverberator('WetDryMix',0.9,'SampleRate',fs);
    data = reverb(x);

    audiowrite(['ReverbSamples\' spk_id 'rv.wav'],data(:,2), fs);
end