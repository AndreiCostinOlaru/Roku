sub init()
    m.imageRowList = m.top.findNode("imageRowList")
    m.button = m.top.findNode("button")
    showImage()
    m.imageRowList.setFocus(true)
    m.button.observeField("buttonSelected", "onButtonSelected")
    m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
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
      if (key = "down" and m.imageRowList.hasFocus()) then
        handled = true
        m.button.setFocus(true)
      else 
        if (key = "up" and m.button.hasFocus()) then
            handled = true
            m.imageRowList.setFocus(true)
        end if
      end if
    end if
    return handled
end function

sub onButtonSelected()
  ? "Button selected."
end sub

sub onRowItemSelected(event)
  data =event.getData()
  ? Substitute("Item Id: {0}", data[1].toStr())
end sub
