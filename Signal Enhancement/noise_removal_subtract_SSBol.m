
[noisy_signal,fs] = audioread("combined.wav");


output = SSBoll79(noisy_signal,fs,0.2);%%signal, sampling frequency, the duration of the noise at the start 

figure;

plot(noisy_signal)
figure;
plot(output)
%sound(noisy_signal,fs)
sound(5*output,fs)