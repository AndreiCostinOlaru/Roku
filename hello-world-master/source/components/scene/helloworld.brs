sub init()
    m.imageRowList = m.top.findNode("imageRowList")
    m.button = m.top.findNode("button")
    showImage()
    m.imageRowList.setFocus(true)
end sub

sub showImage()
    listRoot = CreateObject("roSGNode","ContentNode")
    row = CreateObject("roSGNode","ContentNode")
    for i = 1 to 5 
        rowChild = CreateObject("roSGNode","ContentNode")
        rowChild.FHDPosterUrl = Substitute("pkg:/images/item{0}.jpg",i.toStr())
        row.appendChild(rowChild)
    end for
    
    listRoot.appendChild(row)
    m.imageRowList.content = listRoot
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press then
      if (key = "down") then
        m.button.setFocus(true)
      else 
        if (key = "up") then
            m.imageRowList.setFocus(true)
        end if
      end if
    end if
end function
