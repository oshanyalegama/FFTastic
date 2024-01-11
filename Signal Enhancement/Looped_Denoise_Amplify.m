%Input and output folder paths
input_folder = 'D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test';
denoised_folder = 'D:\Mora\SP CUP\My code\Denoised Amplified\single channel\test';

input_files = dir(fullfile(input_folder, '*.wav'));

%Iterate through each audio recording
for i = 1:length(input_files)
    
    current_file = fullfile(input_folder, input_files(i).name);
    
    [y, Fs] = audioread(current_file);
    
    %Wavelet denoising
    denoised_audio = wdenoise(y);
        
    output_file = fullfile(denoised_folder, [input_files(i).name]);
    audiowrite(output_file, 2*denoised_audio, Fs);
    
end
