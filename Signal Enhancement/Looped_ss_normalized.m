%Input and output folder paths
input_folder = 'D:\Mora\SP CUP\ROBOVOX_SP_CUP_2024\data\single-channel\test';
ss_folder = 'D:\Mora\SP CUP\My code\Spectral Subtracted Normalized\single channel\test';  % SS is not the Nazi thing

input_files = dir(fullfile(input_folder, '*.wav'));

%Iterate through each audio recording
for i = 1:length(input_files)
    
    current_file = fullfile(input_folder, input_files(i).name);
    
    [y, Fs] = audioread(current_file);
    
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
    for j = 1:length(isSilent)
        if isSilent(j)
            % If silence starts, update silenceStart
            if silenceDuration == 0
                silenceStart = j;
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

    if silence < 0.05
        silence = 0.05;
    end

    IS = silence;  % Initial silence length in seconds

    ss_audio = SSBoll79(y_normalized, Fs, IS);
    
    denoised_audio = wdenoise(ss_audio);
    
    % Find the maximum amplitude in the audio
    maxAmp = max(abs(denoised_audio));

    % Calculate the scaling factor
    scalingF = 10^(targetLevel / 20) / maxAmp;

    % Apply the scaling factor to normalize the audio
    denoised_normalized = denoised_audio * scalingF;
    
    output_file = fullfile(ss_folder, [input_files(i).name]);
    audiowrite(output_file, denoised_normalized, Fs);
end