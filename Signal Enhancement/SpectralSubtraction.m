%[y, Fs] = audioread("D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test\0acd7709c9.wav");  %Good

%[y, Fs] = audioread("D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test\0ab53b8add.wav");  %Bad

[y, Fs] = audioread("D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test\0ae2d646bd.wav");  %Drop 

% Normalize the audio to a target level (e.g., 0 dB)
targetLevel = 0;

% Find the maximum amplitude in the audio
maxAmplitude = max(abs(y));

% Calculate the scaling factor
scalingFactor = 10^(targetLevel / 20) / maxAmplitude;

% Apply the scaling factor to normalize the audio
y_normalized = y * scalingFactor;

% Set a threshold for silence (adjust as needed)
silenceThreshold = 0.01;

% Find silent regions
isSilent = abs(y_normalized) < silenceThreshold;

% Initialize variables
silenceStart = 0;
silenceDuration = 0;

% Loop through the samples to find initial silence
for i = 1:length(isSilent)
    if isSilent(i)
        % If silence starts, update silenceStart
        if silenceDuration == 0
            silenceStart = i;
        end
        silenceDuration = silenceDuration + 1;
    else
        % If the first non-silent region is encountered, break the loop
        if silenceDuration > 0
            break;
        end
    end
end
silence = silenceDuration/Fs;
% Display the length of initial silence
fprintf('Initial silence duration: %.2f seconds\n', silence);

if silence < 0.05
    silence = 0.05
end

IS = silence;  % Initial silence length in seconds

ss_audio = SSBoll79(y_normalized, Fs, IS);

sound(y_normalized, Fs); % Original audio
pause(length(y)/Fs); % Wait for original audio to finis

sound(2*ss_audio, Fs); % Filtered audio

figure;
plot(y_normalized);
xlabel('Sample Number');
ylabel('Amplitude');

figure;
plot(ss_audio);
xlabel('Sample Number');
ylabel('Amplitude');