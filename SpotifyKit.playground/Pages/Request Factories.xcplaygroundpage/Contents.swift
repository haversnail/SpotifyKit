/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ***
 
 # SKCatalog & Other Request Factories
 Instead of having to research endpoints, query parameters, response types, and other particulars about the [Spotify Web API](https://developer.spotify.com/web-api/), **SpotifyKit** provides a comprehensive set of methods which both manufacture and perform requests to nearly every endpoint available in the API *(with a few exceptions, which will be discussed later on)*. These methods are accessible through request factories like `SKCatalog` and other **SpotifyKit** types, and attempt to streamline the preparation and execution of requests as best as possible.
 
 ## The Catalog Struct
 For a majority of Spotify media items like albums and tracks, their availability depends on the particular region (or "market," as it's referred to in the Web API) in which that item resides. In lieu of providing this parameter to every individual request, **SpotifyKit** organizes and simplifies these requests with the `SKCatalog` struct.
 
 `SKCatalog` is a request factory containing all of the "top-level" catalog requests, like fetching artists, albums, tracks, categories, and so on, and can be initialized with a given [`Locale`](apple-reference-documentation://hsjpkRNg77).
 */

import SpotifyKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
SPTAuth.defaultInstance().session = SPTSession(userName: username, accessToken: accessToken, expirationDate: Date.distantFuture)

let locale = Locale(identifier: "en_US")
let myCatalog = SKCatalog(locale: locale)

//: This locale serves as the "market" or "country" for which the requests are made:

myCatalog.getAlbum(withID: "01x41UlgUnQ3QX5OLcIKFo") { (album, error) in // requests the album from the "US" market.
    
    if let error = error {
        print(error.localizedDescription)
    }
    
    if let album = album {
        print(album.name)
    }
}

//: In addition, `SKCatalog` contains a static variable called `local`, which returns a catalog instance whose locale is set to `Locale.`[`current`](apple-reference-documentation://hss0reUQUz), or the locale representing the user's region settings at the time the method is called:

SKCatalog.local.getAlbum(withID: "01x41UlgUnQ3QX5OLcIKFo") { (album, error) in
    // ...
}

//: ## Other Requests
//: While most media items are available through `SKCatalog`, there are many requests that you can make from other **SpotifyKit** types as well:

SKCatalog.local.getArtist(withID: "1hCkSJcXREhrodeIHQdav8") { (artist, error) in
    // ...
    
    artist?.getTopTracks { (tracks, error) in // "getTopTracks" is available on SKArtist instances.
        // ...
        
        tracks?.getAudioFeatures { (features, error) in // "getAudioFeatures" is available on any collection of tracks.
            // ...
        }
    }
}

//: Be sure to check out the **SpotifyKit** [documentation]() for a full list of types and their available request methods.

//: > ## Beta Requests
//: > As mentioned earlier, **SpotifyKit** does not contain a request method for *every* available endpoint—in particular, the beta ["Web API Connect"](https://developer.spotify.com/web-api/working-with-connect/) endpoints. Many of these endpoints are designed to control playback of the user's current Spotify player; since **SpotifyKit** also includes the headers from the [Spotify iOS SDK](https://github.com/spotify/ios-sdk), playback control is already available through the `SpotifyAudioPlayback` framework, making request methods for those endpoints redundant. Therefore, **SpotifyKit** only includes those beta requests that aren't available through the SDK, such as transferring playback between devices, and **not** those that control playback. Should you wish to create requests for those endpoints yourself, however, you can easily do so using the techniques covered in the [previous pages](Making%20API%20Requests).

//: ## Factory Methods
//: For every request-performing method in the framework, there is an accompanying factory method for that request. If you want to access the underlying `SKRequest` instance for any given request—say, to inject a different URL session, for example—you can do so like this:

let request = SKCatalog.local.makeAlbumRequest(id: "01x41UlgUnQ3QX5OLcIKFo")

request.urlSession = URLSession.shared

request.perform { (album: SKAlbum?, error) in
    // ...
}

//: The next page will cover those requests that return paginated results.
//: ***
//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
