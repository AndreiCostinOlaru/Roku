sub init()
    m.poster = m.top.findNode("itemPoster")
end sub

sub showContent(event as Object)
    data = event.getData()
    m.poster.uri = data.url
end sub
