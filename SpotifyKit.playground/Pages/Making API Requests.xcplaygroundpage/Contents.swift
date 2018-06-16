/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ***
 
 # Making API Requests
 As the foundation of the framework, the `SKRequest` class is responsible for performing each URL request to the [Spotify Web API](https://developer.spotify.com/documentation/web-api/). It is modeled after the **Social** framework’s [`SLRequest`](apple-reference-documentation://hsp4_7YsJD) class, and aims to mimic its structure and functionality in order to provide a comparable service for interacting with the Web API.
 
 It is designed to streamline both the preparation and the execution of the URL request by providing easy-to-use mechanisms for adding an access token, URL query parameters and multipart body data, and for performing the request with API-specific responses in mind.
 
 As you'll see in [Request Factories](Request%20Factories), nearly all of the available API requests have been created for you by factory methods; however, should you wish to create the requests yourself—for example, to add a [beta request](https://developer.spotify.com/documentation/web-api/guides/using-connect-web-api/) that isn't already provided by the framework—then the following walkthrough will help you get started.
 
 ## Creating an `SKRequest` instance
 You create a new request instance by providing the HTTP request method such as `GET`, `PUT`, `POST`, etc., and the URL for the API endpoint:
 */

import SpotifyKit
import Foundation

let method: SKRequest.HTTPMethod = .GET
let url = URL(string: "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q")!
let request = SKRequest(method: method, url: url)!

/*:
 - Note: URLs must contain the API URL base (`https://api.spotify.com`) or the Authentication URL base (`https://accounts.spotify.com`), or else the initializer will fail.
 
 \
 \
 Alternatively, instead of providing a complete URL to instantiate each request, you can simply provide the API endpoint as a `String`:
 */

let sameRequest = SKRequest(method: method, endpoint: "/v1/artists/53XhwfbYqKCa1cC15pYq2q")!

/*:
 - Note: Endpoint strings can either represent the full URL string or just the path components—however, path components must be based on the `https://api.spotify.com` URL.
 
 \
 \
 Optionally, if the API endpoint requires URL query parameters to fulfill the request (*hint*: most do), you would provide a dictionary of parameters to the request initializer, like so:
 */

let parameters: [String: Any] = ["ids": "53XhwfbYqKCa1cC15pYq2q,7mnBLXK823vNxN3UWB7Gfz"]
let getArtistsRequest = SKRequest(method: .GET, endpoint: "/v1/artists", parameters: parameters)!

//: - Note: If the given URL contains any query items, those items will be removed from the URL and appended to the `parameters` dictionary instead. However, note that any values supplied by the `parameters` argument will overwrite existing URL query items that share the same name.

//: ## Adding Request Body Data
//: For API endpoints that require a request body, you can add a `Data` value (and accompanying content type) to the request as such:

let data = """
{
    "name": "Mr. Robot Soundtracks",
    "description": "When you feel like shattering the grand illusion.",
    "public": true
}
""".data(using: .utf8)!

let newPlaylistRequest = SKRequest(method: .POST, endpoint: "/v1/users/ahavermale/playlists")!
newPlaylistRequest.add(data, type: .json)

//: ## Authorizing Requests
//: `SKRequest` objects use the [Spotify iOS SDK](https://github.com/spotify/ios-sdk)'s `SpotifyAuthentication` framework to authorize their underlying URL request. By default, each request instance contains a weak `apiSession` property that references the [`SPTAuth`](https://spotify.github.io/ios-sdk/Classes/SPTAuth.html) default instance session, which should contain the current access token if the `SPTAuth` session was set before the instantiation of the request:

SPTAuth.defaultInstance().session = SPTSession(userName: username,
                                               accessToken: accessToken,
                                               expirationDate: Date.distantFuture)

let authorizedRequest = SKRequest(method: method, url: url)!
let token = authorizedRequest.apiSession?.accessToken

//: Optionally, you can provide a custom session object after the request has been created, so long as it contains a valid access token:

sameRequest.apiSession = SPTSession(userName: "ahavermale",
                                    accessToken: "s0m3th1ng-val1d",
                                    expirationDate: Date.distantFuture) // Your active session object.

/*:
 ## Performing Requests
 Once the URL request has been prepared, you execute the request by calling one of the `perform(completion:)` methods. There are three available methods for performing the request, each with their own closure type and level of granularity:
 
 * An `SKRequestHandler` closure, which returns the raw JSON data (if any), the HTTP response status code, and/or an error if unsuccessful:
 */


request.perform { (data: Data?, status: SKResponseStatus?, error: Error?) in
    
    if let data = data { /* ... */ }
    if let status = status { /* ... */ }
    if let error = error { /* ... */ }
}

//: * An `SKDecodableHandler` closure, which either returns the data already decoded as the given type, or an error if unsuccessful:

request.perform { (artist: SKArtist?, error: Error?) in
    
    if let artist = artist { /* ... */ }
    if let error = error { /* ... */ }
}

//: * Or, for simpler requests, an `SKErrorHandler` closure, which only returns an error if the request was unsuccessful:

request.perform { (error: Error?) in
    
    if let error = error { /* ... */ }
}

//: ## Further Customization
//: If you want to customize the underlying URL session for a particular request, you can do so using the `urlSession` property:

let myURLSession = URLSession(configuration: .default)
request.urlSession = myURLSession

/*:
 - Note: Unless you're referencing the [shared URL session singleton](apple-reference-documentation://hswpyQK_SL), the session will be invalidated upon deinitialization of the `SKRequest` instance.
 
 \
 \
 Or, if you just want the prepared URL request for use outside of the `SKRequest`, you can access it with the `preparedURLRequest` property:
 */

let urlRequest = authorizedRequest.preparedURLRequest

//: The next page will go into detail on how the request's responses are decoded.
//: ***
//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
