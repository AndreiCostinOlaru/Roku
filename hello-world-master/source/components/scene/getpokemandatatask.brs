sub init()
	m.top.functionName = "getData"
end sub


sub getData()
    pokemonPhotoJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
    listRoot = CreateObject("roSGNode","ContentNode")
    row = populateRowItems(pokemonPhotoJson)
    listRoot.appendChild(row)
    m.top.itemContent = listRoot
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


function populateRowItems(pokemonPhotoJson as Object) as Object
    row = CreateObject("roSGNode","ContentNode")
    row.TITLE = "Pokemons"
    for each item in pokemonPhotoJson
        rowChild = CreateObject("roSGNode","ContentNode")
        rowChild.id = item.id
        rowChild.title = item.title
        rowChild.url = item.url
        rowChild.image_1080_url = item.image_1080_url
        rowChild.description = item.description
        rowChild.FHDPOSTERURL = item.url
        row.appendChild(rowChild)
    end for
    return row
end function