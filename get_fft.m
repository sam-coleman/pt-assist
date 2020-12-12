function [data] = get_fft(file_name, Fs)
%get_fft performs the shifted fast fourier transform on time domain data
%filename: name of data file. Note: must be in Data folder
%Fs: sampling rate data was collected at
%data matrix structure defined below

    addpath('Data\') %add data folder to path
    
    %parse and trim data
    [MotionData] = ParseMatlabAppFinal(file_name);
    a_x = MotionData.Accel(10:end-10,1);
    a_y = MotionData.Accel(10:end-10,2);
    a_z = MotionData.Accel(10:end-10,3);
    
    %take shifted fft
    fft_x = fftshift(fft(a_x));
    fft_y = fftshift(fft(a_y));
    fft_z = fftshift(fft(a_z));
    
    %find shifted frequencies
    N = length(a_x);
    f_shifted = linspace(-pi * Fs, (pi-2/N*pi) * Fs, N) + Fs * pi/N*mod(N,2);
    f_shifted = f_shifted';
    
    %package into data matrix
    %column 1: shifted frequencies
    %column 2: fft of x direction
    %column 3: fft of y direction
    %column 4: fft of z direction
    data = [f_shifted fft_x fft_y fft_z];
end