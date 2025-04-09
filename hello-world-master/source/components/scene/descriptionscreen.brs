sub init()
    m.poster = m.top.findNode("itemPoster")
    m.label = m.top.findNode("description")
end sub

sub showcontent(event as Object)
    data = event.getData()
    m.poster.uri = data.image_1080_url
    m.label.text = data.description
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
