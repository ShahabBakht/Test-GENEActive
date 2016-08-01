function triggerAccData = TriggerAccData(time,AccData)

numEvents = size(time,1);

for eventcount = 1:numEvents
    thisTime = time(eventcount,:);
    
    thisSecond = thisTime(end);
    thismiliSecond = 1000*(thisSecond - floor(thisSecond));
    thisnewmiliSecond = round(thismiliSecond/10)*10;
    
    criticalHour = (thisTime(4) == 23);
    criticalMinute = (thisTime(5) == 59);
    criticalSecond = (thisTime(6) == 59);
    criticalmiliSecond = (thismiliSecond > 995);
    
    
    if ~(criticalHour && criticalMinute && criticalSecond && criticalmiliSecond)
    thisYear = num2str(thisTime(1));
    thisMonth = thisTime(2);
    if thsiTime(2) < 10
        thisMonth = ['0',num2str(thisTime(2))];
    else
        thisMonth = num2str(thisTime(2));
    end
    if thisTime(3) < 10
        thisDat = ['0',num2str(thisTime(3))];
    else
        thisDay = num2str(thisTime(2));
    end
    thisHour = thisTime(4);
    thisMinute = thisTime(5);
    thisSecond = floor(thisTime(6));
    thismiliSecond = thisnewmiliSecond;
    
    
    
%     thisTimeString = [num2str(thisTime(1)),'-',
    
end
end