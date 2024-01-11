%Input and output folder paths
input_folder = 'D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test';
filtered_folder = 'D:\Mora\SP CUP\My code\Filtered\single channel\test';

input_files = dir(fullfile(input_folder, '*.wav'));

%Lowpass filter
f = [0.61875 0.625];   %Stopband edge 5kHz
a = [1 0];  
rp = 0.01;   
rs = 80;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)];
[n,fo,ao,w] = firpmord(f,a,dev);
b_1 = firpm(n,fo,ao,w);

%Highpass filter
f = [0.0115 0.0125]; %stopband edge at 100Hz
a = [0 1];
rp = 0.01;
rs = 80;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)];
[n,fo,ao,w] = firpmord(f,a,dev);
b_2 = firpm(n,fo,ao,w);


%Iterate through each audio recording
for i = 1:length(input_files)
    
    current_file = fullfile(input_folder, input_files(i).name);
    
    [y, Fs] = audioread(current_file);
      
    %Apply filtering
    filtered_lp = filter(b_1, 1, denoised_audio);
    filtered_audio = filter(b_2, 1, filtered_lp);
    
        output_file = fullfile(filtered_folder, [input_files(i).name]);
    audiowrite(output_file, filtered_audio, Fs);
end
