clc;
clear;

% ----------- SERIAL SETUP -----------
port = "COM11";
baudrate = 9600;

arduino = serialport(port, baudrate);
flush(arduino);
disp("Connected to Arduino...");

% ----------- TEXT TO SPEECH SETUP -----------
NET.addAssembly('System.Speech');
speaker = System.Speech.Synthesis.SpeechSynthesizer;
speaker.Rate = 0;

% ==========================================================
%                   FULL SCREEN GUI SETUP
% ==========================================================
creamColor = [1 0.97 0.88];    % Cream background
textColor  = [0 0 0];          % Black font
fontStyle  = 'Arial Black';    % Arial Black font

fig = figure('Name','ASL Gesture to Speech', ...
             'NumberTitle','off', ...
             'MenuBar','none', ...
             'ToolBar','none', ...
             'Color', creamColor, ...
             'Units','normalized', ...
             'Position',[0 0 1 1]);   % FULL SCREEN

movegui(fig,'center');

% ---- Big Center Display ----
hText = uicontrol('Style','text', ...
                  'Units','normalized', ...
                  'FontSize',50, ...
                  'FontWeight','bold', ...
                  'FontName',fontStyle, ...
                  'ForegroundColor',textColor, ...
                  'BackgroundColor',[1 1 1], ...
                  'Position',[0.2 0.40 0.6 0.20], ...
                  'String','Waiting...');

% ---- Bottom Status Bar ----
statusBar = uicontrol('Style','text', ...
                      'Units','normalized', ...
                      'FontSize',18, ...
                      'FontWeight','bold', ...
                      'FontName',fontStyle, ...
                      'BackgroundColor',[1 0.95 0.80], ... % light cream
                      'ForegroundColor',textColor, ...
                      'Position',[0 0 1 0.05], ...
                      'String','Status: Listening for gestures...');

lastGesture = "";

% ----------- MAIN LOOP SETTINGS -----------
pollPause = 0.01; % fastest safe polling

% ==========================================================
%                       MAIN LOOP
% ==========================================================
while ishandle(fig)

    if arduino.NumBytesAvailable > 0

        raw = strtrim(readline(arduino));

        if startsWith(raw, "GESTURE:", "IgnoreCase", true)

            gesture = strtrim(erase(raw, "GESTURE:"));

            if ~isempty(gesture) && gesture ~= lastGesture
                lastGesture = gesture;

                % ========== Update GUI instantly ==========
                set(hText, 'String', gesture);
                set(statusBar, 'String', ['Detected: ' gesture]);
                drawnow limitrate;

                % ========== Speak instantly ==========
                try
                    speaker.SpeakAsyncCancelAll();
                catch
                end

                pause(0.003);
                speaker.SpeakAsync(gesture);
            end
        end
    end

    pause(pollPause);
end