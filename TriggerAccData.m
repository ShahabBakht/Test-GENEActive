function TriggerAccData = TriggerAccData(time,GENEActiveData)

numEvents = size(time,1);

for eventcount = 1:numEvents
    thisTime = time(eventcount,:);
    clock_ds = downsampleClock(thisTime);
    
    
    
    
%     thisTimeString = [num2str(thisTime(1)),'-',
    
end
end

function clock_ds = downsampleClock(clock_hs)
% This function downsamples the clock from 1ms sampling rate which is
% MATLAB clock output to 10 ms which is GENEActive sampling rate.
% clock_hs and clock_ds have the same format as MATLAB clock output.

thisTime = clock_hs;
thisSecond = thisTime(end);
thismiliSecond = 1000*(thisSecond - floor(thisSecond));
thisSecond = floor(thisSecond);

criticalHour = (thisTime(4) == 23);
criticalMinute = (thisTime(5) == 59);
criticalSecond = (thisSecond == 59);
criticalmiliSecond = (thismiliSecond > 995);

thisYear = thisTime(1);
thisMonth = thisTime(2);
thisDay = thisTime(3);
% if thsiTime(2) < 10
%     thisMonth = ['0',num2str(thisTime(2))];
% % else
%     thisMonth = num2str(thisTime(2));
% end
% if thisTime(3) < 10
%     thisDay = ['0',num2str(thisTime(3))];
% else
%    
% end
    
if ~(criticalHour || criticalMinute || criticalSecond || criticalmiliSecond)
    
    thisHour = thisTime(4);
    thisMinute = thisTime(5);
    thisSecond = floor(thisTime(6));
    thisnewmiliSecond = round(thismiliSecond/10)*10;
    thismiliSecond = thisnewmiliSecond;
    
elseif criticalmiliSecond && ~(criticalHour || criticalMinute || criticalSecond)
    
    thisHour = thisTime(4);
    thisMinute = thisTime(5);
    thisSecond = floor(thisTime(6)) + 1;
    thismiliSecond = 0;
    
elseif (criticalmiliSecond && criticalSecond) && ~(criticalHour || criticalMinute)
    
    thisHour = thisTime(4);
    thisMinute = thisTime(5) + 1;
    thisSecond = 0;
    thismiliSecond = 0;

elseif (criticalmiliSecond && criticalSecond && criticalMinute) && ~(criticalHour)

    thisHour = thisTime(4) + 1;
    thisMinute = 0;
    thisSecond = 0;
    thismiliSecond = 0;

elseif (criticalmiliSecond && criticalSecond && criticalMinute && criticalHour) 

    thisDay = thisDay + 1;
    thisHour = 0;
    thisMinute = 0;
    thisSecond = 0;
    thismiliSecond = 0;

end

clock_ds = [thisYear, thisMonth, thisDay, thisHour, thisMinute, (thisSecond + thismiliSecond/1000)];

end

function numClock = str2numGENEActiveClock(strClock)
% This function takes the GENEActive string format clock as input and gives
% the MATLAB clock format as output.

end