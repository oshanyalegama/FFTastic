folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
all_objects = dir(folderpath);
all_objects(1:2) = []; % Get rid of . and ..
num = size(all_objects);
n = num(1,1);

%Creates the same number of babble clips as there is in the enrollment file
for i=1:n
    r = randi([1,n],1,10);
    
    %Takes 10 random enrollment clips to make a single babble clip
    [x,fs] = audioread(fullfile(folderpath,all_objects(r(1,1)).name));
    maxSz = size(x);
    maxSz = maxSz(1,1);
    BabbleArr = x;
    
    for c = 2:9
        [x,fs] = audioread(fullfile(folderpath,all_objects(r(1,c)).name));
        Sz = size(x);
        if maxSz==Sz(1,1)
            BabbleArr = BabbleArr + x;
        elseif maxSz>Sz(1,1)
            zeroArr = zeros(maxSz,1);
            zeroArr(1:Sz(1,1),1) = x;
            BabbleArr = BabbleArr + zeroArr;
        else
            zeroArr = zeros(Sz);
            zeroArr(1:maxSz,1) = BabbleArr;
            BabbleArr = zeroArr;
            BabbleArr = BabbleArr + x;
            maxSz = Sz(1,1);
        end
    end
    
    audiowrite(['BabbleSamples\BabbleClip_' num2str(i) '.wav'],BabbleArr/10, fs);

end