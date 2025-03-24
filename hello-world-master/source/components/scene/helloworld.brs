sub init()
    m.imageRowList = m.top.findNode("imageRowList")
    m.button = m.top.findNode("button")
    m.imageRowList.setFocus(true)
    m.button.observeField("buttonSelected", "onButtonSelected")
    m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
    m.getPokemonDataTask = CreateObject("roSGNode", "GetPokemonDataTask")
    m.getPokemonDataTask.ObserveField("itemContent", "onFetchPokemonData")
	  m.getPokemonDataTask.control = "RUN"
    m.newScreen = CreateObject("roSGNode", "DescriptionScreen")
    m.newScreen.visible = false
    m.top.appendChild(m.newScreen)
    m.getVideoData = CreateObject("roSGNode", "GetVideoDataTask")
    m.getVideoData.ObserveField("itemContent", "onFetchVideoData")
	  m.getVideoData.control = "RUN"
end sub


sub onFetchPokemonData()
  m.imageRowList.content =  m.getPokemonDataTask.itemcontent
end sub

sub onFetchVideoData()
  m.getVideoData.itemcontent = m.getVideoData.itemcontent
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
  data =event.getData()
  m.newScreen.content = m.imageRowList.content.getChild(data[0]).getChild(data[1])
  m.newScreen.visible = true
end sub
