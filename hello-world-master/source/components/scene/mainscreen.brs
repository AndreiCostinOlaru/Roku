sub init()
  m.imageRowList = m.top.findNode("imageRowList")
  m.imageRowList.content = populateImageRowList()
  m.button = m.top.findNode("button")
  m.layoutGroup = m.top.findNode("layoutGroup")
  m.imageRowList.setFocus(true)
  m.button.observeField("buttonSelected", "onButtonSelected")
  m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
  m.getPokemonDataTask = CreateObject("roSGNode", "GetPokemonDataTask")
  m.getPokemonDataTask.ObserveField("itemContent", "onFetchPokemonData")
  m.getPokemonDataTask.control = "RUN"
  m.getVideoData = CreateObject("roSGNode", "GetVideoDataTask")
  m.getVideoData.ObserveField("itemContent", "onFetchVideoData")
  m.getVideoData.control = "RUN"
  m.buttonMarkupGridScreen = m.top.findNode("buttonMarkupGridScreen")
  m.buttonMarkupGridScreen.observeField("buttonSelected", "onbuttonMarkupGridScreenSelected")
  m.translationAnimation = createButtonsRowListAnimation(m.layoutGroup)
  m.rowListFocusTimer = createTimer(5, true)
  startTimer(m.rowListFocusTimer)
  m.rowListFocusTimer.ObserveField("fire", "onRowListTimer")
  m.imageRowList.ObserveField("rowItemFocused", "onRowListItemFocused")
end sub

sub onFetchPokemonData(event as Object)
  row = event.getData()
  listRoot = CreateObject("roSGNode","ContentNode")
  listRoot.appendChild(row)
  m.imageRowList.content = listRoot
  m.markupData = row
  m.top.signalBeacon("AppLaunchComplete")
end sub

sub onFetchVideoData(event as Object)
  m.videoData = event.getData()
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press
    if key = "down" and m.imageRowList.hasFocus()
      handled = true
      reverseStartAnimation(m.translationAnimation)
      m.button.setFocus(true)
      stopTimer(m.rowListFocusTimer)
    else if key = "up" and (m.button.hasFocus() or m.buttonMarkupGridScreen.hasFocus())
      handled = true
      reverseStartAnimation(m.translationAnimation)
      m.imageRowList.setFocus(true)
      startTimer(m.rowListFocusTimer)
    else if key = "right" and m.button.hasFocus()
      handled = true
      m.buttonMarkupGridScreen.setFocus(true)
    else if key = "left" and m.buttonMarkupGridScreen.hasFocus()
      handled = true
      m.button.setFocus(true)
    end if
  end if
  return handled
end function

sub onButtonSelected()
  navigateToVideoScreen(m.videoData)
end sub

sub onRowItemSelected(event as Object)
  data =event.getData()
  screenContent = m.imageRowList.content.getChild(data[0]).getChild(data[1])
  stopTimer(m.rowListFocusTimer)
  navigateToDescriptionScreen(screenContent)
end sub

sub navigateToDescriptionScreen(screenContent as Object)
  m.newScreen = CreateObject("roSGNode", "DescriptionScreen")
  m.newScreen.content = screenContent
  m.newScreen.ObserveField("backTrigger", "onBackFromDescriptionScreen")
  m.top.appendChild(m.newScreen)
  m.newScreen.setFocus(true)
end sub

sub onBackFromDescriptionScreen()
  m.top.removeChild(m.newScreen)
  startTimer(m.rowListFocusTimer)
  m.imageRowList.setFocus(true)
end sub

sub navigateToVideoScreen(screenContent as Object)
  m.newVideoScreen = CreateObject("roSGNode", "VideoScreen")
  m.newVideoScreen.content = screenContent
  m.newVideoScreen.ObserveField("backVideoTrigger", "onBackFromVideoScreen")
  m.top.appendChild(m.newVideoScreen)
  m.newVideoScreen.setFocus(true)
end sub

sub onBackFromVideoScreen()
  m.top.removeChild(m.newVideoScreen)
  m.button.setFocus(true)
end sub

sub onbuttonMarkupGridScreenSelected()
  navigateToMarkupGridScreen(m.markupData)
end sub

sub navigateToMarkupGridScreen(screenContent as Object)
  m.newMarkupScreen = CreateObject("roSGNode", "MarkupGridScreen")
  m.newMarkupScreen.content = screenContent
  m.newMarkupScreen.ObserveField("backTrigger", "onBackFromMarkupGridScreen")
  m.top.appendChild(m.newMarkupScreen)
  m.newMarkupScreen.setFocus(true)
end sub

sub onBackFromMarkupGridScreen()
  m.top.removeChild(m.newMarkupScreen)
  m.buttonMarkupGridScreen.setFocus(true)
end sub

sub onMainSceneSuspend(args as dynamic)
  if m.newVideoScreen <> invalid
    player = m.newVideoScreen.findNode("video")
    player.control = "stop"
    m.top.removeChild(m.newVideoScreen)
    m.button.setFocus(true)
    m.newVideoScreen = invalid
  end if
end sub

sub onMainSceneResume(args as dynamic)
  m.top.signalBeacon("AppResumeComplete")
end sub

function populateImageRowList() as Object
  listRoot = CreateObject("roSGNode","ContentNode")
  row = CreateObject("roSGNode","ContentNode")
  row.TITLE = "Pokemons"
  for x = 1 To 5
    rowChild = CreateObject("roSGNode","ContentNode")
    rowChild.url = "pkg:/images/gray.png"
    row.appendChild(rowChild)
  end for
  listRoot.appendChild(row)
  return listRoot
end function

sub onRowListTimer(event as Object)
  indexFocusedItem = m.imageRowList.rowItemFocused[1]
  newIndexFocusedItem = (indexFocusedItem + 1) mod 7
  m.imageRowList.jumpToRowItem = [0, newIndexFocusedItem]
end sub

sub onRowListItemFocused(event as Object)
  resetTimer(m.rowListFocusTimer, 5)
end sub
