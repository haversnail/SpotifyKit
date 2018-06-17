/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ***
 
 # Pagination
 As you'll notice, many [Spotify Web API](https://developer.spotify.com/documentation/web-api/) endpoints return paginated results. The API uses two different mechanisms to accomplish this: "[paging objects](https://developer.spotify.com/documentation/web-api/reference/object-model/#paging-object)" and "[cursor-based paging objects](https://developer.spotify.com/documentation/web-api/reference/object-model/#cursor-based-paging-object)." These objects are represented in **SpotifyKit** by two distinct types: `Page` and `CursorPage`, respectively. Both types share conformance to a base protocol, `PagingCollection`, which inherits all the benefits and complexity guarantees of a [`RandomAccessCollection`](apple-reference-documentation://hs6VFJWl1b), making pages as versatile and efficient as any other collection type:
 */

import SpotifyKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
SPTAuth.defaultInstance().session = SPTSession(userName: username, accessToken: accessToken, expirationDate: Date.distantFuture)

SKCatalog.local.search(for: [.playlists], matching: "Stranger Things") { (results, error) in

    // Returns results containing a page of playlists matching our keywords:
    if let playlists = results?.playlists {

        // And because pages are collections, we get to use all the fun stuff, like "lazy" and "filter":
        let spotifyPlaylists = playlists.lazy.filter { $0.owner.id == "spotify" }

        spotifyPlaylists.first?.getTracks { (tracks, error) in
            
            tracks?.forEach { print($0.name) }
        }
    }
}

/*:
 ## Offset-Based Paging
 `Page` types conform to `OffsetPagingCollection`, a protocol which inherits from `PagingCollection`, but also introduces the `offset` property. As the API's default mechanism for pagination, offset-based paging collections use an "offset" or index value to identify the overall index of the first item in the page.
 
 To request a specific page of results, most request methods accept a `Pagination` value, which can be created by providing this offset in tandem with a limit:
 */

let firstPage = Pagination(limit: 5) // Defines page parameters with a limit of five and a default offset of zero.
let secondPage = Pagination(limit: 5, offset: 5)

//: Alternatively, you can also specify the page "number" that you want, which depends on the size of the page:

let alsoTheSecondPage = Pagination(limit: 5, page: 2) // Same as specifying "limit: 5, offset: 5"

SKCatalog.local.getNewReleases(page: secondPage) { (albums, error) in // Gets the second page of newly-released albums.
    
    if let albums = albums {
        let startingIndexOfPage = albums.offset // This should be equal to the offset we defined in the request.
        let numberOfItemsInPage = albums.limit // This should also be equal to what we defined in the request.
        let theSameValueAsAbove = albums.count // And this should be equal to the limit.
    }
}

/*:
 ## Cursor-Based Paging
 Cursor-based paging objects are represented in the framework by their own type, `CursorPage`: a generic struct that conforms to the `CursorPagingCollection` protocol. Used by only a few endpoints, these collections depend on a more detailed traversal mechanism than their offset-based counterparts; whereas offset-based collections only rely on an index value to mark the beginning of a page, *cursor*-based collections introduce a set of "cursors" (as the Web API calls them) which identify the first and last elements in that particular page. As they're currently used, these pages specifically represent items that are in some sort of chronological order; as such, their cursors represent the most recent or least recent item in the page, and are used in subsequent requests to navigate forward or backward in time.
 
 Request methods that return these types of collections will accept one of these cursors as a parameter, allowing you to traverse pages accordingly:
 */

// By default, this request fetches the five most recently played tracks:
SKPlayer.getRecentTracks(limit: 5) { (tracks, error) in
    
    // Since the request returns SKRecentTrack types sorted from most recent to least,
    // the "oldest" cursor represents the playback date of the last track in the page:
    if let tracks = tracks, let oldestTrackDate = tracks.cursors.oldest {
        
        // Now we can use that cursor to fetch the next page of tracks (in this case, going backward in time):
        SKPlayer.getRecentTracks(before: oldestTrackDate, limit: 5) { (tracks, error) in
            // ...
        }
    }
}

//: To better understand the dynamic between these paging collection protocols and their associated types, check out the **SpotifyKit** [documentation](https://haversnail.github.io/SpotifyKit/documentation/).

/*:
 ## Navigating Paginated Responses
 As an alternative to specifying an offset or cursor every time you want to fetch another page, both offset-based and cursor-based collections provide a pair of `nextURL` and `previousURL` properties, each containing the respective URL for the adjacent page of items, if available:
 */

SKCatalog.local.getCategories { (categories, error) in
    
    if let categories = categories {
        
        if let url = categories.nextURL {
            
            SKRequest(method: .GET, url: url)!.perform { (categories: Page<SKCategory>?, error) in
                // wow much request. so verbose.
            }
        }
    }
}

//: To simplify things, however, you could also use the `getNext` or `getPrevious` methods available on every paging collection:

SKCatalog.local.getCategories { (categories, error) in
    
    categories?.getNext { (categories, error) in // This does the same thing.
        // If there is no next page, then both `categories` and `error` will be nil.
    }
}

//: The next page covers how **SpotifyKit** integrates the [Spotify iOS SDK](https://github.com/spotify/ios-sdk).
//: ***
//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
