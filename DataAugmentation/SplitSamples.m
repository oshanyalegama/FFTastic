folderpath = 'samples';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
all_dirs = all_objects([all_objects.isdir]==1);

%Looping through all the sub folders
for c = 1:size(all_dirs)
    dirName = all_dirs(c).name;

    spkNum = dirName(1);
    if spkNum == '7'
        spkNum = '78';
    end
    spkVal = dirName(1:end);

    %Reading the audio file and times
    [x,fs] = audioread(fullfile('samples',dirName,"sound.wav"));
    channel05 = x(:,5); %Choose Channel
    
    data = importdata(fullfile('samples',dirName,'annotations.txt'));

    values = data.data;

    szConv = size(values);
    startTime = values(2,2);

    %Breaking into time segments
    for i = 3:szConv(1)
        endTime = values(i,1);
        startSample = floor(startTime * fs);
        endSample = ceil(endTime * fs);
        SubSignal = channel05(startSample:endSample,:);
        audiowrite(['NewSamples\spk_' spkNum '-' spkVal '_d' num2str(i-2) '_ch5.wav'],SubSignal, fs)
        startTime = values(i,2);
    end

    SubSignal = channel05(floor(startTime*fs):end,:);
    audiowrite(['NewSamples\spk_' spkNum '-' spkVal '_d' num2str(szConv(1)-1) '_ch5.wav'],SubSignal, fs)

end
