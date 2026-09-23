function imu_analysis_demo()
% 1. Setup Parameters
sample_rate = 100.0; % Sampling Frequency (Hz)
duration = 10.0;     % Duration (seconds)
t = (0:1/sample_rate:duration - 1/sample_rate)';
num_samples = length(t);

% 2. Generate Ground Truth Signals (True Motion)
% Accelerometer (m/s^2) - X, Y motion & Z gravity
acc_x_true = 1.5 * sin(2 * pi * 0.5 * t);
acc_y_true = 0.8 * cos(2 * pi * 0.25 * t);
acc_z_true = 9.81 + 0.5 * sin(2 * pi * 1.0 * t);

% Gyroscope (rad/s) - Angular velocities
gyro_x_true = 0.5 * cos(2 * pi * 0.5 * t);
gyro_y_true = 0.3 * sin(2 * pi * 0.8 * t);
gyro_z_true = 0.1 * ones(size(t));

% 3. Add Gaussian Noise and Gyro Drift
rng(42); % Set seed for reproducibility
acc_noise = 0.4 * randn(num_samples, 3);
gyro_noise = 0.08 * randn(num_samples, 3);
gyro_drift = linspace(0, 0.25, num_samples)'; % Low-frequency bias

raw_acc = [acc_x_true, acc_y_true, acc_z_true] + acc_noise;
raw_gyro = [gyro_x_true + gyro_drift, gyro_y_true, gyro_z_true] + gyro_noise;

% 4. Statistical Analysis (Summary Output)
fprintf('=== Raw Accelerometer Summary (X-axis) ===\n');
fprintf('Mean: %.4f | Std: %.4f | Min: %.4f | Max: %.4f\n\n', ...
    mean(raw_acc(:,1)), std(raw_acc(:,1)), min(raw_acc(:,1)), max(raw_acc(:,1)));

% 5. Noise Reduction Filtering

% Method A: Moving Average Filter (Window Size = 9)
window_size = 9;
ma_acc_x = movmean(raw_acc(:,1), window_size);
ma_gyro_x = movmean(raw_gyro(:,1), window_size);

% Method B: Butterworth Low-Pass Filter (Cutoff = 3 Hz, Order = 4)
cutoff_freq = 3.0; 
nyquist = sample_rate / 2;
norm_cutoff = cutoff_freq / nyquist;
[b, a] = butter(4, norm_cutoff, 'low');

% Zero-phase filtering using filtfilt
butter_acc_x = filtfilt(b, a, raw_acc(:,1));
butter_gyro_x = filtfilt(b, a, raw_gyro(:,1));

% 6. Visualization
figure('Name', 'IMU Noise Reduction Analysis', 'NumberTitle', 'off');

% Plot Accelerometer X
subplot(2,1,1);
plot(t, raw_acc(:,1), 'Color', [0.7 0.7 0.7], 'DisplayName', 'Raw Signal'); hold on;
plot(t, ma_acc_x, '--b', 'LineWidth', 1.2, 'DisplayName', 'Moving Avg (w=9)');
plot(t, butter_acc_x, '-r', 'LineWidth', 1.5, 'DisplayName', 'Butterworth Low-Pass (3 Hz)');
hold off;
grid on;
title('Accelerometer X-Axis Noise Reduction');
ylabel('Acc X (m/s^2)');
legend('Location', 'northeast');

% Plot Gyroscope X
subplot(2,1,2);
plot(t, raw_gyro(:,1), 'Color', [0.7 0.7 0.7], 'DisplayName', 'Raw Signal'); hold on;
plot(t, ma_gyro_x, '--b', 'LineWidth', 1.2, 'DisplayName', 'Moving Avg (w=9)');
plot(t, butter_gyro_x, '-r', 'LineWidth', 1.5, 'DisplayName', 'Butterworth Low-Pass (3 Hz)');
hold off;
grid on;
title('Gyroscope X-Axis Noise Reduction');
xlabel('Time (s)');
ylabel('Gyro X (rad/s)');
legend('Location', 'northeast');
end