sub init()
    m.poster = m.top.findNode("itemPoster")
    m.label = m.top.findNode("itemName")
    m.mask = m.top.findNode("itemMask")
end sub

sub showcontent(event as Object)
    data = event.getData()
    m.poster.uri = data.url
    m.label.text = data.title
end sub

sub showfocus()
    scale = 1 + (m.top.focusPercent * 0.08)
    m.mask.opacity = 0.75 - (m.top.focusPercent * 0.75)
  end sub
