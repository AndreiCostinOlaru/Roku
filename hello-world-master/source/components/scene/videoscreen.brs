sub init()
    m.video = m.top.findNode("video")
end sub

sub showcontent(event as Object)
    data = event.getData()
    m.video.content = data
    video.control = "play"
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press then
        if (key ="back") then
            m.top.backTrigger = true
            handled = true
        end if
    end if
    return handled
end function
