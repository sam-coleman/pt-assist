function f_data = move_avg_filt(time_data, num_pt)
%does num_pt moving average filter on data in time domain
%time data: N x 3 matrix
%num_pt is odd between 3-9

x = time_data.Accel(10:end-10, 1);
y = time_data.Accel(10:end-10, 2);
z = time_data.Accel(10:end-10, 3);
data = [x y z];
f_data = ones(length(x)-num_pt, 3);
if num_pt == 3
    pos = 2;
    for i=pos:length(x) - pos
    f_data(i-1, 1) = 1/num_pt*(data(i-1,1) + data(i,1) + data(i+1,1));
    f_data(i-1, 2) = 1/num_pt*(data(i-1,2) + data(i,2) + data(i+1,2));
    f_data(i-1, 3) = 1/num_pt*(data(i-1,3) + data(i,3) + data(i+1,3));
    end
elseif num_pt == 5
    pos = 3;
    for i=pos:length(x) - pos
    f_data(i-2, 1) = 1/num_pt*(data(i-2, 1) + data(i-1,1) + data(i,1) + data(i+1,1) + data(i+2, 1));
    f_data(i-2, 2) = 1/num_pt*(data(i-2, 2) + data(i-1,2) + data(i,2) + data(i+1,2) + data(i+2, 2));
    f_data(i-2, 3) = 1/num_pt*(data(i-2, 3) + data(i-1,3) + data(i,3) + data(i+1,3) + data(i+2, 3));
    end
elseif num_pt == 7
    pos = 4;
    for i=pos:length(x) - pos
    f_data(i-3, 1) = 1/num_pt*(data(i-3, 1) + data(i-2, 1) + data(i-1,1) + data(i,1) + data(i+1,1) + data(i+2, 1) +  data(i+3, 1));
    f_data(i-3, 2) = 1/num_pt*(data(i-3, 2) + data(i-2, 2) + data(i-1,2) + data(i,2) + data(i+1,2) + data(i+2, 2) +  data(i+3, 2));
    f_data(i-3, 3) = 1/num_pt*(data(i-3, 3) + data(i-2, 3) + data(i-1,3) + data(i,3) + data(i+1,3) + data(i+2, 3) +  data(i+3, 3));
    end
elseif num_pt == 9
    pos = 5;
    for i=pos:length(x) - pos
    f_data(i-4, 1) = 1/num_pt*(data(i-4, 1) + data(i-3, 1) + data(i-2, 1) + data(i-1,1) + data(i,1) + data(i+1,1) + data(i+2, 1) +  data(i+3, 1) + data(i+4, 1));
    f_data(i-4, 2) = 1/num_pt*(data(i-4, 2) + data(i-3, 2) + data(i-2, 2) + data(i-1,2) + data(i,2) + data(i+1,2) + data(i+2, 2) +  data(i+3, 2) + data(i+4, 2));
    f_data(i-4, 3) = 1/num_pt*(data(i-4, 3) + data(i-3, 3) + data(i-2, 3) + data(i-1,3) + data(i,3) + data(i+1,3) + data(i+2, 3) +  data(i+3, 3) + data(i+4, 3));
    end
end