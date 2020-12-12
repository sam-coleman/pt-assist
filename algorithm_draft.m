function [] = algorithm_draft(file_name)
% algorithm_draft classifies a paloff press execution as correct or incorrect
% file_name: name of data file. Note: must be in Data folder

addpath('Data\') %add data folder to path
trial = process_data(file_name); %get data into useable frequency domain values

%calculate rms values for x,y,z axes
x_rms = rms(trial(:,2)); 
y_rms = rms(trial(:,3));
z_rms = rms(trial(:,4));

%max rms values for good exercise
%these were calculated from looking at sample data for good and bad trials
x_thresh = 40;
y_thresh = 41;
z_thresh = 30;

%calculate percent error for all axes (trial vs max acceptable rms value)
x_error = (x_rms-x_thresh)/x_thresh;
y_error = (y_rms-y_thresh)/y_thresh;
z_error = (z_rms-z_thresh)/z_thresh;

errors = [x_error y_error z_error]; %package into vector for ease

%classify exercise as correct or incorrect based on errors in each axis
if (max(errors) == errors(1) && errors(1) > 0) %if x_erorr is greatest and positive
    disp('You are doing the paloff press incorrectly.')
    disp('You are going too inwards/outwards, try being more perpendicular to your body. Consult your PT if needed.')
elseif (max(errors) == errors(3) && errors(3) > 0) %if z_erorr is greatest and positive
    disp('You are doing the paloff press incorrectly.')
    disp('You are going goo high or low, try being more parallel to the ground. Consult your PT if needed.')
else %if not above, you are correct!
    disp('Good Job! You are doing the paloff press correctly.')
    disp('Be sure to always exercise within your limits.')
end
end

function fft_data = process_data(file_name)
% process_data gets data ready to be fed into algorithm
% file_name: name of data file. Note: must be in Data folder
% returns data in frequency domain (with lowpass filter and 0Hz removed)

data_time = ParseMatlabAppFinal(file_name); %parse data file from Matlab App
data_filt = move_avg_filt(data_time, 5); %perform moving average filter (low-pass filter) on time data
fft_data = fft_from_time(data_filt, 100); %take fft of filtered data
fft_data = remove_0(fft_data); %remove 0Hz frequency
end

function freq_data = remove_0(freq_data)
% remove_0 removes the 0Hz frequency from all axes
% input freq_data: frequency data matrix (N x 3)

    %for each axis: find max frequency (will be 0Hz) and make amplitude 0
    for i=2:4
        [~, Index] = max(freq_data(:,i));
        freq_data(Index, i) = 0;
    end
end