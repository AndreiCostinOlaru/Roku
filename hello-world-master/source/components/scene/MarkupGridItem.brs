sub init()
    m.poster = m.top.findNode("itemPoster")
    m.label = m.top.findNode("itemName")
    m.mask = m.top.findNode("roundedMask")
    m.background = m.top.findNode("background")
    m.background.blendColor = "0xAAAAAAFF"
end sub

sub showContent(event as Object)
    data = event.getData()
    m.poster.uri = data.url
    m.label.text = data.title
    m.background.uri = "pkg:/images/rectangle_24.png"
    m.mask.maskUri = "pkg:/images/rectangle_24.png"
end sub

sub showFocus()
    m.background.opacity = m.top.focusPercent
end sub
