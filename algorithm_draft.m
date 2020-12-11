% function result = form_correct(filename,maybe something else)
clc
clear all

addpath('/Data')
trial = filter_data('B2');
x_rms = rms(trial(:,2))
y_rms = rms(trial(:,3))
z_rms = rms(trial(:,4))

x_thresh = 32;
y_thresh = 41;
z_thresh = 30;

x_error = (x_rms-x_thresh)/x_thresh
y_error = (y_rms-y_thresh)/y_thresh
z_error = (z_rms-z_thresh)/z_thresh

errors = [x_error y_error z_error];

if (max(errors) == errors(1) && errors(1) > 0)
    disp('bad x')
elseif (max(errors) == errors(3) && errors(3) > 0)
    disp('bad z')
else
    disp('gucci swag')
end
% if (x_rms > x_thresh || y_rms > y_thresh || z_rms > z_thresh)
%     if (x_rms > x_thresh) && (y_rms <= y_thresh) && (z_rms <= z_thresh)  %just x wrong
%         disp('wrong x')
%     elseif (y_rms > y_thresh) && (x_rms <= x_thresh) && (z_rms <= z_thresh)  %just y wrong
%         disp('wrong y')
%     elseif (z_rms > z_thresh) && (x_rms <= x_thresh) && (y_rms <= y_thresh)  %just z wrong
%         disp('wrong z')
%     elseif (x_rms > x_thresh) && (y_rms > y_thresh) && (z_rms <= z_thresh)  %x and y wrong
%         disp('wrong x and y')
%     elseif (y_rms > y_thresh) && (x_rms <= x_thresh) && (z_rms > z_thresh)  %y and z wrong
%         disp('wrong y and z')
%     elseif (z_rms > z_thresh) && (x_rms > x_thresh) && (y_rms <= y_thresh)  %x and z wrong
%         disp('wrong x and z')
%     elseif (x_rms > x_thresh) && (y_rms > y_thresh) && (z_rms > z_thresh)  %all three wrong
%         disp('all wrong')
    end
else
    disp('Nice! Your form was correct.')
end



%end





function fft_data = filter_data(file_name)
data_time = ParseMatlabAppFinal(file_name);
data_filt = move_avg_filt(data_time, 5);
fft_data = fft_from_time(data_filt, 100);
fft_data = remove_0(fft_data);
end

function freq_data = remove_0(freq_data)
    
    for i=2:4
        [~, Index] = max(freq_data(:,i));
        freq_data(Index, i) = 0;
    end
end