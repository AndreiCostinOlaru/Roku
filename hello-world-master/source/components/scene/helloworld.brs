sub init()
    m.imageRowList = m.top.findNode("imageRowList")
    m.button = m.top.findNode("button")
    m.imageRowList.setFocus(true)
    m.button.observeField("buttonSelected", "onButtonSelected")
    m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
    m.getRequestTask = CreateObject("roSGNode", "GetPokemonDataTask")
    m.getRequestTask.ObserveField("itemContent", "onFetchData")
	  m.getRequestTask.control = "RUN"
    m.newScreen = CreateObject("roSGNode", "DescriptionScreen")
    m.newScreen.visible = false
    m.top.appendChild(m.newScreen)
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
      else if (key = "up" and m.button.hasFocus()) then
            handled = true
            m.imageRowList.setFocus(true)
      else if (key ="back") then
        ? "back"
        ? m.newScreen
        ? m.top.findNode("descriptionScreen")
        m.newScreen.visible = false
        handled = true
      end if
    end if
    return handled
end function

sub onButtonSelected()
  ? "Button selected."
end sub

sub onRowItemSelected(event)
  ' TODO: all screens list
  ' 
  data =event.getData()
  ' newScreen = CreateObject("roSGNode", "DescriptionScreen")
  m.newScreen.content = m.imageRowList.content.getChild(data[0]).getChild(data[1])
  ' m.newScreen = newScreen
  m.newScreen.visible = true
end sub
