sub init()
    m.imageRowList = m.top.findNode("imageRowList")
    m.button = m.top.findNode("button")
    m.imageRowList.setFocus(true)
    m.button.observeField("buttonSelected", "onButtonSelected")
    m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
    m.getRequestTask = CreateObject("roSGNode", "GetPokemonDataTask")
    m.getRequestTask.ObserveField("itemContent", "onFetchData")
	  m.getRequestTask.control = "RUN"
end sub


sub onFetchData(event as Object)
  m.imageRowList.content =  event.getData()
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
