sub init()
	m.top.functionName = "getData"
end sub


sub getData()
    videoDataJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
    itemContent = CreateObject("roSGNode","ContentNode")
    videoData = videoDataJson[0]
    itemContent.id = videoData.id
    itemContent.title = videoData.title
    itemContent.FHDPosterUrl = videoData.poster
    itemContent.url = videoData.stream.url 'does not work
    itemContent.streamformat = videoData.stream.format
    itemContent.url = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8" 'placeholder
    itemContent.description = videoData.description
    m.top.itemContent = itemContent
end sub

function executeGetRequest(url) 
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
            if type(msg) = "roUrlEvent" then
                code = msg.GetResponseCode()
                if code = 200
                    response = ParseJson(msg.GetString())
                    return response
                end if
            end if
        end while
    end if
end function
