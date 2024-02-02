input_folder = 'C:\Users\DELL\Documents\SP Cup\test';
input_files = dir(fullfile(input_folder, '*.wav'));
output_folder = "wavelet denoised\";

for i = 1:length(input_files)
  
    current_file = fullfile(input_folder, input_files(i).name);
    [audioIn,fs] = audioread(current_file);

    audioIn = wdenoise(audioIn);
    audiowrite(['wavelet denoised\' input_files(i).name],audioDetected,fs);
   
end 