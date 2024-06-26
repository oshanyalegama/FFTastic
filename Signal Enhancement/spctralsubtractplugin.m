% Test bench script for: SpectralSubtractor.
% Generated by Audio Test Bench on 21-Jan-2024 14:20:01 UTC+05:30.

% Create test bench input and output
input_path = 'C:\Users\DELL\Documents\SP Cup\example.wav';
fileReader = dsp.AudioFileReader(Filename=input_path);
deviceWriter = audioDeviceWriter(SampleRate=fileReader.SampleRate, ...
    BitDepth='24-bit integer');
[x,fs]= audioread(input_path);
figure;
plot(x)
% Create AudioFileWriter to write the final result
output_path = "C:\Users\DELL\Documents\SP Cup\result.wav";
fileWriter = dsp.AudioFileWriter(output_path, 'SampleRate', fileReader.SampleRate);


% Create the objects under test
sut1 = audiopluginexample.SpectralSubtractor;
setSampleRate(sut1,fileReader.SampleRate);

% Open parameter tuners for interactive tuning during simulation
%tuner1 = parameterTuner(sut1);
%drawnow

sut1.Mag2Subtract = 0.2;
% Stream processing loop
nUnderruns = 0;
while ~isDone(fileReader)
    % Read from input, process, and write to output
    in = fileReader();
    out1 = process(sut1,in);
    nUnderruns = nUnderruns + deviceWriter(out1);
    
    % Process parameterTuner callbacks
    drawnow limitrate
    
    fileWriter(out1);

end

[x2,fs]=audioread(output_path);
figure;
plot(2.66*x2)
sound( 2.66*x2, fs)


% Clean up
release(fileReader)
release(deviceWriter)
release(fileWriter)
