% ----------------------------------------------------------------------- %
% Function 'fourier_epicycles' computes the required number of epicycles to
% draw the given curve, specified by the given coordinates. These epicycles
% have different radii, phase and rotate at different frequencies. Note   %
% that the number of epicycles would be the same as the length of the     %
% curve.                                                                  %
%                                                                         %
%   Input parameters:                                                     %
%       - curve_x:      X coordinates of the curve.                       %
%       - curve_y:      Y coordinates of the curve.                       %
%       - no_circles:   (Optional) Maximum number of circles. The maximum %
%                       drawing accuracy is reached if the no_circles is  %
%                       exactly the number of points of the curve (which  %
%                       is the default value: no_circles=length(curve_x);)%
% ----------------------------------------------------------------------- %
%   Versions:                                                             %
%       - 1.0:          (20/09/2019) Original script.                     %
%       - 1.1:          (21/09/2019) Max no. circles is added.            %
% ----------------------------------------------------------------------- %
%   Script information:                                                   %
%       - Version:      1.1.                                              %
%       - Author:       V. Martínez-Cagigal                               %
%       - Date:         21/09/2019                                        %
% ----------------------------------------------------------------------- %
%   Example of use:                                                       %
%       load('heart.mat'); fourier_epicycles(curve_x, curve_y);           %
% ----------------------------------------------------------------------- %
function fourier_epicycles(curve_x, curve_y, no_circles)

    % Default no. circles
    if nargin < 3, no_circles = length(curve_x); end
    if no_circles > length(curve_x)
        warning(['The number of circles cannot be higher than the number' ...
            'of points. The number of circles has been set to %i.', length(curve_x)]);
        no_circles = length(curve_x);
    end
    
    % Downsample the curve if required
    if no_circles < length(curve_x)
        curve_x = resample(curve_x, no_circles, length(curve_x));
        curve_y = resample(curve_y, no_circles, length(curve_y));
        curve_x = [curve_x(:); curve_x(1)];
        curve_y = [curve_y(:); curve_y(1)];
    end
    
    % Parameters
    pause_duration = 0;     % No. seconds of pause between plots
    periods_to_plot = 1;    % No. periods of the main circle until it stops
    
    % Compute the DFT of the complex number
    Z = complex(curve_x(:), curve_y(:));
    [X, freq, radius, phase] = dft_epicycles(Z,length(Z));
    time_step = 2*pi/length(X);
    
    % Draw the result
    time = 0;
    wave = [];
    generation = 1;
    h = figure;
    handle = axes('Parent',h);
    while generation < periods_to_plot*length(X)+2
        [x, y] = draw_epicycles(freq, radius, phase, time, wave, handle);
        
        % Add the next computed point to the wave curve
        wave = [wave; [x,y]];
        
        % Increment time and generation
        time = time + time_step;
        generation = generation + 1;
        pause(pause_duration);
    end
end

% Computes the DFT parameters of a complex vector and provides the
% frequency, radius and phase of each of the epicycles
function [X, freq, radius, phase] = dft_epicycles(Z, N)
    % Discrete Fourier Transform
    X = fft(Z, N)/N;       % DFT of the complex series
    freq = 0:1:N-1;     % Frequency of the circles
    radius = abs(X);    % Radii of the circles
    phase = angle(X);   % Initial phase of the circles
    
    % Sort by radius
    [radius, idx] = sort(radius, 'descend');
    X = X(idx);
    freq = freq(idx);
    phase = phase(idx);
end

% Draws the epicycles and the result line at a given time
function [x, y] = draw_epicycles(freq, radius, phase, time, wave, handle)
    % Compute coordinates
    x = 0;      
    y = 0;
    N = length(freq);
    centers = NaN(N,2);
    radii_lines = NaN(N,4);
    for i = 1:1:N
        % Store the previous coordinates, which will be the center of the
        % new circle
        prevx = x;
        prevy = y;
        
        % Get the new coordinates of the joint point
        x = x + radius(i) * cos(freq(i)*time + phase(i));
        y = y + radius(i) * sin(freq(i)*time + phase(i));
        
        % Circle centers
        centers(i,:) = [prevx, prevy];
        
        % Radii lines
        radii_lines(i,:) = [prevx, x, prevy, y];
    end    
    
    % Plotting
    cla;        % IMPORTANT: Clearing axes
                % Note that viscircles do not clear the axes and thus, they
                % should be cleared in order to avoid lagging issues due to
                % the amount of objects that are stacked
    % Circles
    viscircles(handle, centers, radius, 'Color', 0.5 * [1, 1, 1], 'LineWidth', 0.1);
    hold on;
    
    % Lines that join the center with the tangent points
    plot(handle, radii_lines(:,1:2), radii_lines(:,3:4), 'Color', 0.5*[1 1 1], 'LineWidth', 0.1);
    hold on;
    
    % Result line
    if ~isempty(wave), plot(handle, wave(:,1), wave(:,2), 'k', 'LineWidth', 2); hold on; end
    
    % Pointer
    plot(handle, x, y, 'or', 'MarkerFaceColor', 'r');
    hold off;
    
    % Plot limits
    %xmax = sum(radius);
    %axis([-xmax xmax -xmax xmax]);
   
    axis equal;
    axis off;
    drawnow;
end