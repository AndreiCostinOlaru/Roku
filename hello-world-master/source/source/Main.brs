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
    inputObject=CreateObject("roInput")

    m.port = CreateObject("roMessagePort")

    screen.setMessagePort(m.port)
    inputObject.setMessagePort(m.port)

    scene = screen.CreateScene("MainScreen")
    scene.backgroundUri = "pkg:/images/Dragon.jpg"
    screen.show()

    keepAppAlive()
end sub

sub keepAppAlive()
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roInputEvent"
            inputData = msg.getInfo()
            if inputData.DoesExist("mediaType") and inputData.DoesExist("contentId")
                deeplink = {
                    id: inputData.contentId,
                    type: inputData.mediaType
                }
                print "got input deeplink= "; deeplink
            end if
        end if
    end while
end sub
