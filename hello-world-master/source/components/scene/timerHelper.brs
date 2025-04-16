function createTimer(duration as Integer, repeat as Boolean) as Object
    timer = createObject("roSGNode", "Timer")
    timer.duration = duration
    timer.repeat = repeat
    return timer
end function

sub startTimer(timer as Object)
    timer.control = "start"
end sub

sub stopTimer(timer as Object)
    timer.control = "stop"
end sub
