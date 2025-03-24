sub init()
	m.top.functionName = "getData"
end sub


sub getData()
    videoDataJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/videos")
    itemContent = CreateObject("roSGNode","ContentNode")
    itemContent.id = videoDataJson[0].id
    itemContent.title = videoDataJson[0].title
    itemContent.FHDPosterUrl = videoDataJson[0].poster
    itemContent.url = videoDataJson[0].stream.url
    itemContent.streamformat = videoDataJson[0].stream.format
    itemContent.title = videoDataJson[0].description
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
