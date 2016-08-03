function TriggerGENEActivData = TriggerAccData(time,GENEActivData,GENEActivClock,preTriggerWin,postTriggerWin)

numEvents = size(time,1);
GENEActivNumClock = nan(length(GENEActivClock),6);
for clockcount = 1:length(GENEActivClock)
    strClock = GENEActivClock{clockcount};
    GENEActivNumClock(clockcount,:) = str2numGENEActiveClock(strClock);
end

TriggerGENEActivData = nan(numEvents,preTriggerWin + postTriggerWin + 1);
for eventcount = 1:numEvents
    thisTime = time(eventcount,:);
    clock_ds = downsampleClock(thisTime);
    iseqClock = (GENEActivNumClock == repmat(clock_ds,size(GENEActivNumClock,1),1));
    pointer = find(sum(iseqClock,2) == 6);
    if preTriggerWin > pointer
        TriggerGENEActivData(eventcount,:) = GENEActivData(1:(pointer+postTriggerWin));
    elseif (length(GENEActivData) - pointer) < postTriggerWin
        TriggerGENEActivData(eventcount,:) = GENEActivData((pointer-preTriggerWin):end);
    else
        TriggerGENEActivData(eventcount,:) = GENEActivData((pointer-preTriggerWin):(pointer+postTriggerWin));
    end
    
    
   
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
    

    
if criticalmiliSecond && ~(criticalHour || criticalMinute || criticalSecond)
    
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
    
else 
    
    thisHour = thisTime(4);
    thisMinute = thisTime(5);
    thisSecond = floor(thisTime(6));
    thisnewmiliSecond = round(thismiliSecond/10)*10;
    thismiliSecond = thisnewmiliSecond;
    
end

clock_ds = [thisYear, thisMonth, thisDay, thisHour, thisMinute, (thisSecond + thismiliSecond/1000)];

end

function numClock = str2numGENEActiveClock(strClock)
% This function takes the GENEActive string format clock as input and gives
% the MATLAB clock format as output.
thisYear = str2num(strClock(1:4));
thisMonth = str2num(strClock(6:7));
thisDay = str2num(strClock(9:10));
thisHour = str2num(strClock(12:13));
thisMinute = str2num(strClock(15:16));
thisSecond = str2num(strClock(18:19));
thismiliSecond = str2num(strClock(21:23));

numClock = [thisYear,thisMonth,thisDay,thisHour,thisMinute,thisSecond+thismiliSecond/1000];

end