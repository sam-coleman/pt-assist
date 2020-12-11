function [data] = fft_from_time(time_data, Fs)
%time_data 3xn
%col 1: x
%col 2: y
%col 3: z

%take shifted fft
fft_x = fftshift(fft(time_data(:,1)));
fft_y = fftshift(fft(time_data(:,2)));
fft_z = fftshift(fft(time_data(:,3)));

%find shifted frequencies
N = length(time_data(:,1));
f_shifted = linspace(-pi * Fs, (pi-2/N*pi) * Fs, N) + Fs * pi/N*mod(N,2);
f_shifted = f_shifted';

%package into data matrix
%column 1: shifted frequencies
%column 2: fft of x direction
%column 3: fft of y direction
%column 4: fft of z direction
data = [f_shifted fft_x fft_y fft_z];
end