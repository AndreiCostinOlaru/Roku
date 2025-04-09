sub init()
    m.background = m.top.findNode("background")
    m.markUpGrid = m.top.findNode("markupGrid")
end sub

sub showcontent(event as Object)
    m.background.color = "#808080"
    m.markUpGrid.content = event.getData()
    m.markUpGrid.setFocus(true)
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
