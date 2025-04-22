sub init()
    m.top.functionName = "getData"
end sub


sub getData()
    videoDataJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
    m.top.itemContent = setUpVideoContent(videoDataJson[0])
end sub

function executeGetRequest(url as String) as Object
    port = CreateObject("roMessagePort")
    request = setUpHttpRequest(url)
    request.setMessagePort(port)
    request.AsyncGetToString()
    msg = wait(0, port)
    if isSuccessfulHttpResponse(msg)
        response = ParseJson(msg.GetString())
        return response
    end if
end function

function setUpHttpRequest(url as String) as Object
    request = CreateObject("roUrlTransfer")
    request.setMessagePort(CreateObject("roMessagePort"))
    request.SetUrl(url)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("X-Roku-Reserved-Dev-Id", "")
    request.InitClientCertificates()
    return request
end function

function isSuccessfulHttpResponse(msg as Object) as Boolean
    return type(msg) = "roUrlEvent" and msg.GetResponseCode() = 200
end function

function setUpVideoContent(videoData as Object) as Object
    itemContent = CreateObject("roSGNode","ContentNode")
    drmParams = {
        keySystem: "Widevine"
        licenseServerURL: "https://cwip-shaka-proxy.appspot.com/no_auth"
    }
    itemContent.id = videoData.id
    itemContent.title = "DRM Video" 
    itemContent.FHDPosterUrl = videoData.poster
    itemContent.url = "https://cdn.bitmovin.com/content/assets/art-of-motion_drm/mpds/11331.mpd" 
    itemContent.streamformat = "dash" 
    itemContent.drmParams = drmParams
    itemContent.description = videoData.description

    'Video populated from backend data:
    'itemContent.url = videoData.stream.url
    'itemContent.streamformat = videoData.stream.format
    'itemContent.title = videoData.title

    return itemContent
end function
