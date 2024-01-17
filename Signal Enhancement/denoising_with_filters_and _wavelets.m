[speech,fs] = audioread("ROBOVOX_SP_CUP_2024\data\samples\1_1_1_0\sound.wav");
startTime = 6.039475;
endTime = 9.120143;
clear_audio = speech(startTime*fs:endTime*fs,5);
noisy_audio = speech(startTime*fs:endTime*fs,4);
figure;
plot(clear_audio)
pspectrum(clear_audio)
title('clear')
fixed_noisy_audio = circshift(noisy_audio,-finddelay(clear_audio, 10*noisy_audio));
%fixed_noisy_audio = wdenoise(fixed_noisy_audio);
fixed_noisy_audio = highpass(fixed_noisy_audio, 0.05);
fixed_noisy_audio = lowpass(fixed_noisy_audio, 0.9);

frequenciesToAttenuate = [0.2 0.45];
filterOrder = 8;
gain = -4;
centerFreq = 0.325;
bandwidth = 0.25;
%stopped_fixed_noisy_audio = bandstop(fixed_noisy_audio, [0.2 0.45]);
%[b, a] = butter(filterOrder, frequenciesToAttenuate, 'stop');
[b,a] = designParamEQ(filterOrder,gain,centerFreq,bandwidth);
% % Apply the filter to the signal
myFilter = dsp.BiquadFilter( ...
    SOSMatrixSource="Input port", ...
    ScaleValuesInputPort=false);
stopped_fixed_noisy_audio = myFilter( fixed_noisy_audio,b, a);
figure;
% plot(15*fixed_noisy_audio)
% title('fixed noisy')
pspectrum(8*noisy_audio)
% figure;
% plot(15*noisy_audio)
 title('noisy')
% %pspectrum(15*stopped_fixed_noisy_audio)
% sound(15*fixed_noisy_audio,fs)
% figure;
% plot(clear_audio)
% title('normal')


% Plot the original signal, the spectrum, and the filtered signal on the same figure
figure;

% Plot the original signal in the time domain
subplot(3,1,1);
plot(clear_audio);
title('clear audio');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot the spectrum of the original signal
subplot(3,1,2);
plot(10*noisy_audio);
title('Noisy audio');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Plot the filtered signal in the time domain
subplot(3,1,3);
plot(10*noisy_audio);
title('Fixed noisy audio');
xlabel('Time (s)');
ylabel('Amplitude');
%sound(clear_audio,fs)
sound(10*stopped_fixed_noisy_audio,fs)