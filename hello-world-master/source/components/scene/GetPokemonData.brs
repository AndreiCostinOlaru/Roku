sub init()
	m.top.functionName = "getData"
end sub

sub getData()
    pokemonPhotoJson = executeGetRequest("https://my-json-server.typicode.com/bogdanterzea/pokemon-server/photos")
    rowContent = populateRowItems(pokemonPhotoJson)
    m.top.itemContent = rowContent
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

function populateRowItems(pokemonPhotoJson as Object) as Object
    rowContent = CreateObject("roSGNode","ContentNode")
    rowContent.TITLE = "Pokemons"

    for each pokemonData in pokemonPhotoJson
        rowChild = createPokemonItem(pokemonData)
        rowContent.appendChild(rowChild)
    end for

    return rowContent
end function

function createPokemonItem(pokemonData as Object) as Object
    pokemon = CreateObject("roSGNode","itemContentNode")
    pokemon.id = pokemonData.id
    pokemon.title = pokemonData.title
    pokemon.url = pokemonData.url
    pokemon.image1080Url = pokemonData.image_1080_url
    pokemon.description = pokemonData.description
    pokemon.FHDPOSTERURL = pokemonData.url
    
    return pokemon
end function
