/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ****
 
 # Making API Requests
 As the foundation of the framework, the `SKRequest` class is responsible for performing each URL request to the Spotify Web API. It is modeled after the Social framework’s [SLRequest](apple-reference-documentation://hsp4_7YsJD) class, and aims to mimic its structure and functionality in order to provide a comparable service for interacting with the Spotify Web API.
 
 ## Creating an `SKRequest` instance
 You create a new request instance by providing the HTTP request method such as `GET`, `PUT`, `POST`, etc., and the URL for the API endpoint:
 
 > If the given URL contains any query items, those items will be removed from the URL and stored in the `parameters` property.
 >
 > URLs must contain the base API URL (`https://api.spotify.com`) or the base Authentication URL (`https://accounts.spotify.com`), or else the initializer will fail.
 */

import SpotifyKit
import Foundation

let method: HTTPRequestMethod = .GET
let url = URL(string: "https://api.spotify.com/v1/artists/53XhwfbYqKCa1cC15pYq2q")!
let request = SKRequest(method: method, url: url)

//: Optionally, if the API endpoint requires URL query parameters to fulfill the request (*hint*: most do), you would provide a dictionary of parameters to the request initializer, like so:

let parameters: [String: Any] = ["ids": "53XhwfbYqKCa1cC15pYq2q,7mnBLXK823vNxN3UWB7Gfz"]
let requestWithParameters = SKRequest(method: .GET,
                                      url: url.deletingLastPathComponent(),
                                      parameters: parameters)

//: Alternatively, instead of providing a complete URL to instantiate each request, you can simply provide the API endpoint as a `String`:
//: > Endpoint strings can be provided as either the full URL string or the path components. Path components must be based on the `https://api.spotify.com` URL.

let yetAnotherRequest = SKRequest(method: .GET, endpoint: "/v1/artists", parameters: parameters)

//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
