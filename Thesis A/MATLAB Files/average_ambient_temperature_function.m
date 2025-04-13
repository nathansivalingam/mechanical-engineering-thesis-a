clc
filename = 'CoolTerm Capture 2025-04-07 11-41-23.txt';
fid = fopen(filename, 'r');

if fid == -1
    error('Cannot open file');
end

% Ask user for HH:MM input
target_time = input('Enter target time (HH:MM): ', 's');

fifth_col_values = [];

while ~feof(fid)
    line = fgetl(fid);
    
    if ischar(line) && ~isempty(strtrim(line))
        cols = strsplit(strtrim(line), '\t');
        
        if length(cols) >= 5
            datetime_str = cols{1};  % Example: '2025-04-07 13:40:29'
            
            try
                dt = datetime(datetime_str, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
                current_time_str = datestr(dt, 'HH:MM');  % Extract HH:MM
            catch
                continue;
            end
            
            if strcmp(current_time_str, target_time)
                disp(line);
                val = str2double(cols{5});
                if ~isnan(val)
                    fifth_col_values(end+1) = val;
                end
            end
        end
    end
end

fclose(fid);

if ~isempty(fifth_col_values)
    avg_val = mean(fifth_col_values);
    fprintf('Average of 5th column for %s entries: %.2f\n', target_time, avg_val);
else
    fprintf('No matching entries found for %s\n', target_time);
end
