sub init()
    m.top.functionName = "getData"
end sub


sub getData()
    videoDataJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
    m.top.itemContent = populateItemContent(videoDataJson[0])
end sub

function executeGetRequest(url as String) as Object
    port = CreateObject("roMessagePort")
    request = CreateObject("roUrlTransfer")
    request.setMessagePort(port)
    request.SetUrl(url)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("X-Roku-Reserved-Dev-Id", "")
    request.InitClientCertificates()
    if request.AsyncGetToString()
        while true
            msg = wait(0, port)
            if type(msg) = "roUrlEvent"
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    return response
                end if
            end if
        end while
    end if
end function

function populateItemContent(videoData as Object) as Object
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
