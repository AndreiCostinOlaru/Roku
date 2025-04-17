sub init()
  m.imageRowList = m.top.findNode("imageRowList")
  m.buttonVideo = m.top.findNode("buttonVideo")
  m.layoutGroup = m.top.findNode("layoutGroup")
  m.buttonMarkupGridScreen = m.top.findNode("buttonMarkupGridScreen")

  m.imageRowList.setFocus(true)
  m.imageRowList.content = populateImageRowList()
  
  m.getPokemonDataTask = CreateObject("roSGNode", "GetPokemonDataTask")
  m.getVideoData = CreateObject("roSGNode", "GetVideoDataTask")
  m.translationAnimation = createButtonsRowListAnimation(m.layoutGroup)
  m.rowListFocusTimer = createTimer(5, true)

  m.buttonVideo.observeField("buttonSelected", "onButtonVideoSelected")
  m.imageRowList.observeField("rowItemSelected", "onRowItemSelected")
  m.getPokemonDataTask.ObserveField("itemContent", "onFetchPokemonData")
  m.getVideoData.ObserveField("itemContent", "onFetchVideoData")
  m.buttonMarkupGridScreen.observeField("buttonSelected", "onButtonMarkupGridScreenSelected")
  m.rowListFocusTimer.ObserveField("fire", "onRowListTimer")
  m.imageRowList.ObserveField("rowItemFocused", "onRowListItemFocused")

  m.getPokemonDataTask.control = "RUN"
  m.getVideoData.control = "RUN"
 
  startTimer(m.rowListFocusTimer)
end sub

sub onFetchPokemonData(event as Object)
  rowContent = event.getData()
  rowListRootContent = CreateObject("roSGNode","ContentNode")
  rowListRootContent.appendChild(rowContent)
  m.imageRowList.content = rowListRootContent
  m.markupGridData = rowContent
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
      m.buttonVideo.setFocus(true)
      stopTimer(m.rowListFocusTimer)
    else if key = "up" and (m.buttonVideo.hasFocus() or m.buttonMarkupGridScreen.hasFocus())
      handled = true
      reverseStartAnimation(m.translationAnimation)
      m.imageRowList.setFocus(true)
      startTimer(m.rowListFocusTimer)
    else if key = "right" and m.buttonVideo.hasFocus()
      handled = true
      m.buttonMarkupGridScreen.setFocus(true)
    else if key = "left" and m.buttonMarkupGridScreen.hasFocus()
      handled = true
      m.buttonVideo.setFocus(true)
    end if
  end if
  return handled
end function

sub onButtonVideoSelected()
  navigateToVideoScreen(m.videoData)
end sub

sub onRowItemSelected(event as Object)
  data = event.getData()
  screenContent = m.imageRowList.content.getChild(data[0]).getChild(data[1])
  stopTimer(m.rowListFocusTimer)
  navigateToDescriptionScreen(screenContent)
end sub

sub navigateToDescriptionScreen(screenContent as Object)
  m.newDescriptionScreen = CreateObject("roSGNode", "DescriptionScreen")
  m.newDescriptionScreen.content = screenContent
  m.newDescriptionScreen.ObserveField("backTrigger", "onBackFromDescriptionScreen")
  m.top.appendChild(m.newDescriptionScreen)
  m.newDescriptionScreen.setFocus(true)
end sub

sub onBackFromDescriptionScreen()
  m.top.removeChild(m.newDescriptionScreen)
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
  m.buttonVideo.setFocus(true)
end sub

sub onbuttonMarkupGridScreenSelected()
  navigateToMarkupGridScreen(m.markupGridData)
end sub

sub navigateToMarkupGridScreen(screenContent as Object)
  m.newMarkupGridScreen = CreateObject("roSGNode", "MarkupGridScreen")
  m.newMarkupGridScreen.content = screenContent
  m.newMarkupGridScreen.ObserveField("backTrigger", "onBackFromMarkupGridScreen")
  m.top.appendChild(m.newMarkupGridScreen)
  m.newMarkupGridScreen.setFocus(true)
end sub

sub onBackFromMarkupGridScreen()
  m.top.removeChild(m.newMarkupGridScreen)
  m.buttonMarkupGridScreen.setFocus(true)
end sub

sub onMainSceneSuspend(args as dynamic)
  if m.newVideoScreen <> invalid
    player = m.newVideoScreen.findNode("video")
    player.control = "stop"
    m.top.removeChild(m.newVideoScreen)
    m.buttonVideo.setFocus(true)
    m.newVideoScreen = invalid
  end if
end sub

sub onMainSceneResume(args as dynamic)
  m.top.signalBeacon("AppResumeComplete")
end sub

function populateImageRowList() as Object
  rowListRootContent = CreateObject("roSGNode","ContentNode")
  rowContent = CreateObject("roSGNode","ContentNode")
  rowContent.TITLE = "Pokemons"
  for x = 1 To 5
    rowChild = CreateObject("roSGNode","ContentNode")
    rowChild.url = "pkg:/images/gray.png"
    rowContent.appendChild(rowChild)
  end for
  rowListRootContent.appendChild(rowContent)
  return rowListRootContent
end function

sub onRowListTimer(event as Object)
  indexFocusedItem = m.imageRowList.rowItemFocused[1]
  newIndexFocusedItem = (indexFocusedItem + 1) mod 7
  m.imageRowList.jumpToRowItem = [0, newIndexFocusedItem]
end sub

sub onRowListItemFocused(event as Object)
  resetTimer(m.rowListFocusTimer, 5)
end sub
