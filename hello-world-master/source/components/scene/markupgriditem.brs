sub init()
    m.poster = m.top.findNode("itemPoster")
    m.label = m.top.findNode("itemName")
end sub

sub showcontent(event as Object)
    data = event.getData()
    m.poster.uri = data.url
    m.label.text = data.title
end sub
