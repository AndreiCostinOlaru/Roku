sub init()
    m.background = m.top.findNode("background")
    m.markupGrid = m.top.findNode("markupGrid")
end sub

sub showContent(event as Object)
    m.background.color = "#808080"
    m.markupGrid.content = event.getData()
    m.markupGrid.setFocus(true)
end sub


function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if key ="back"
            m.top.backTrigger = true
            handled = true
        end if
    end if
    return handled
end function
