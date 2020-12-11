function [data] = get_fft(filename, Fs)
%performs the shifted fft on data collected from phone
    
    %parse and trim data
    [MotionData] = ParseMatlabAppFinal(filename);
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