sub init()
    m.poster = m.top.findNode("itemPoster")
end sub

sub showcontent(event)
 data = event.getData()
 ? data
 m.poster.uri = data.fhdposterurl
end sub
