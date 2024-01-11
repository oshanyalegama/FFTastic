enrol_folderpath = 'ROBOVOX_SP_CUP_2024\data\single-channel\enrollment';
enrol_all_objects = dir(enrol_folderpath);
enrol_all_objects(1:2) = []; % Get rid of . and ..
enrol_num = size(all_objects);
enrol_n = enrol_num(1,1);

babble_folderpath = 'BabbleSamples';
babble_all_objects = dir(babble_folderpath);
babble_all_objects(1:2) = []; % Get rid of . and ..
babble_num = size(all_objects);
babble_n = babble_num(1,1);

if enrol_n ~= babble_n
    disp('Different number of Babble files and Enrollment files')
else
    enrol_n = n;
    for c=1:n
        dirName = enrol_all_objects(c).name;
        spk_id = extractBefore(dirName,'ch');
        
        [enrol_x,enrol_fs] = audioread(fullfile(enrol_folderpath,enrol_all_objects(c).name));
        [babble_x,babble_fs] = audioread(fullfile(babble_folderpath,babble_all_objects(c).name));
        enrol_x = enrol_x*2;

        enSz = size(enrol_x);
        enSz = enSz(1,1);

        babSz = size(babble_x);
        babSz = babSz(1,1);

        if babSz==enSz
            NewAudio = babble_x + enrol_x;
        elseif babSz>enSz
            NewAudio = babble_x(1:enSz,1) + enrol_x;
        else
            zeroArr = zeros(enSz,1);
            zeroArr(1:babSz(1,1),1) = babble_x;
            NewAudio = zeroArr + enrol_x;
        end
        audiowrite(['BabEnrolSamples\' spk_id 'bab.wav'],NewAudio, enrol_fs);
    end
end