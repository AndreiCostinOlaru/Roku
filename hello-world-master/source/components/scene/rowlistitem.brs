sub init()
    m.poster = m.top.findNode("itemPoster")
end sub

sub showcontent(event)
 data = event.getData()
 m.poster.uri = data.url
end sub
