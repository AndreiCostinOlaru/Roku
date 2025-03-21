sub init()
    m.poster = m.top.findNode("itemPoster")
    m.label = m.top.findNode("description")
end sub

sub showcontent(event)
 data = event.getData()
 m.poster.uri = data.image_1080_url
 m.label.text = data.description
end sub
