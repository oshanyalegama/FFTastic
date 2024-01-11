



%Audio read
[y, Fs] = audioread('D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test\0ab53b8add.wav');


%Lowpass filter
f = [0.61875 0.625];   %Stopband edge 5kHz
a = [1 0];  
rp = 0.01;   
rs = 80;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)];
[n,fo,ao,w] = firpmord(f,a,dev);
b_1 = firpm(n,fo,ao,w);
freqz(b_1,1,16000)


%Highpass filter
f = [0.0115 0.0125]; %stopband edge at 100Hz
a = [0 1];
rp = 0.01;
rs = 80;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)];
[n,fo,ao,w] = firpmord(f,a,dev)
b_2 = firpm(n,fo,ao,w);
freqz(b_2,1,16000)

%Wavelet denoising
denoised_audio = wdenoise(y);

%Apply filtering
filtered_lp = filter(b_1, 1, denoised_audio);
filtered_audio = filter(b_2, 1, filtered_lp);

           
%denoised_audio = wdenoise(filtered_audio); %Wavelet denoising of filtered


t = 0:1/Fs:1; % Time vector (1 second signal)
N = length(filtered_audio);

X = fft(filtered_audio); %Filtered
X_magnitude = abs(X(1:N/2+1)); 

Y = fft(y);  %Original
Y_magnitude = abs(Y(1:N/2+1));

Z = fft(denoised_audio);  %Denoised
Z_magnitude = abs(Z(1:N/2+1));


f_axis = (0:N/2) * (Fs/N);

% Plot the FFT Original
figure;
plot(f_axis, Y_magnitude);
title('Spectrum of original signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Plot the FFT of filtered
figure;
plot(f_axis, X_magnitude);
title('Spectrum of filtered signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Plot the FFT of denoised
figure;
plot(f_axis, Z_magnitude);
title('Spectrum of denoised signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


sound(y, Fs); % Original audio
pause(length(y)/Fs); % Wait for original audio to finis

sound(filtered_audio, Fs); % Filtered audio
pause(length(y)/Fs); % Wait for original audio to finis

sound(denoised_audio, Fs); % Denoised audio

output_file_original = 'D:\Mora\SP CUP\My code\Testing\single-channel\test\Case3\0ab53b8add.wav'; %Replave with file name

audiowrite(output_file_original, y, Fs);

output_file_filtered = 'D:\Mora\SP CUP\My code\Testing\single-channel\test\Case1\0ab53b8add.wav'; %Replave with file name

audiowrite(output_file_filtered, 2*filtered_audio, Fs);

output_file_denoised = 'D:\Mora\SP CUP\My code\Testing\single-channel\test\Case2\0ab53b8add.wav'; %Replave with file name

audiowrite(output_file_denoised, 2*denoised_audio, Fs);