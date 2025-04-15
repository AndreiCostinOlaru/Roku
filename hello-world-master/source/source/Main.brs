'*************************************************************
'** Hello World example 
'** Copyright (c) 2015 Roku, Inc.  All rights reserved.
'** Use of the Roku Platform is subject to the Roku SDK License Agreement:
'** https://docs.roku.com/doc/developersdk/en-us
'*************************************************************

sub Main(args as Dynamic)
    print "in showChannelSGScreen"
    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    m.portDeepLink=createobject("roMessagePort")
    InputObject=createobject("roInput")
    InputObject.setmessageport(m.portDeepLink)

    scene = screen.CreateScene("MainScreen")
    scene.backgroundUri = "pkg:/images/Dragon.jpg"
    screen.show()

    while true
        msgDeepLink = wait(0, m.portDeepLink)
        msgDeepLinkType = type(msgDeepLink)
        if msgDeepLinkType = "roInputEvent"
            inputData = msgDeepLink.getInfo()
            if inputData.DoesExist("mediaType") and inputData.DoesExist("contentId")
                deeplink = {
                    id: inputData.contentID,
                    type: inputData.mediaType
                }
                print "got input deeplink= "; deeplink
            end if
        end if
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
