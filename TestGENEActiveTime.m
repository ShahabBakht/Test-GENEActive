function [timePressKey,timeLeaveKey, globals] = TestGENEActiveTime

NumTrials = 20;
OnButtonTime = 2;
PressButtonTime = 2;
LeaveButtonTime = 2;

addpath('D:\Project Codes\General-Setup');
globals =  setup_PTB();
% Select specific text font, style and size:
Screen('TextFont',globals.win, 'Courier New');
Screen('TextSize',globals.win, 14);
Screen('TextStyle', globals.win, 1+2);

escapeKey = KbName('ESCAPE');
while KbCheck; end % Wait until all keys are released.

for trcount = 1:NumTrials
    
    timeNow = GetSecs;
    while GetSecs <= (timeNow + OnButtonTime)
        [nx, ny, ~] = DrawFormattedText(globals.win, 'Place your finger on the ESCAPE key', 'center', 'center', 0);
        Screen('DrawText', globals.win, 'Place your finger on the ESCAPE key',  nx, ny, [255, 0, 0, 255]);
        Screen('Flip',globals.win);
    end
    
    
    while 1
        [nx, ny, ~] = DrawFormattedText(globals.win, 'Press the ESCAPE key', 'center', 'center', 0);
        Screen('DrawText', globals.win, 'Press the ESCAPE key', nx, ny, [255, 0, 0, 255]);
        Screen('Flip',globals.win);
        [ keyIsDown, ~, ~ ] = KbCheck;
        if keyIsDown
            timePressKey(trcount,:) = clock;
            break;
        end
    end
    
    
    timeNow = GetSecs;
    while GetSecs <= (timeNow + PressButtonTime)
        [nx, ny, ~] = DrawFormattedText(globals.win, 'Hold on the key', 'center', 'center', 0);
        Screen('DrawText', globals.win, 'Hold on the key', nx, ny, [255, 0, 0, 255]);
        Screen('Flip',globals.win);
    end
    
    while 1
        [nx, ny, ~] = DrawFormattedText(globals.win, 'Leave the key and move your hand up', 'center', 'center', 0);
        Screen('DrawText', globals.win, 'Leave the key and move your hand up', nx, ny, [255, 0, 0, 255]);
        Screen('Flip',globals.win);
        [ keyIsDown, seconds, ~ ] = KbCheck;
        if ~keyIsDown
            timeLeaveKey(trcount,:) = clock;
            break;
        end
    end
    
    timeNow = GetSecs;
    while GetSecs <= (timeNow + LeaveButtonTime)
        [nx, ny, ~] = DrawFormattedText(globals.win, 'Keep your hand up', 'center', 'center', 0);
        Screen('DrawText', globals.win, 'Keep your hand up', nx, ny, [255, 0, 0, 255]);
        Screen('Flip',globals.win);
    end
    
    
end

ShowCursor()
ListenChar(1);
Screen('CloseAll');
