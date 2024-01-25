input_folder = 'C:\Users\DELL\Documents\SP Cup\standardized test ssbol better noise';


input_files = dir(fullfile(input_folder, '*.wav'));

for i = 1:length(input_files)
        current_file = fullfile(input_folder, input_files(i).name);
        [audioIn,fs] = audioread(current_file);
        VADidx = detectSpeech(audioIn,fs);
        VADmask = sigroi2binmask(VADidx,numel(audioIn));
        audioDetected = audioIn(VADmask);
        
        audiowrite(['standardized test ssbol with VAD\' input_files(i).name],audioDetected,fs);
end