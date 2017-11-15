/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ***
 
 # Decoding Responses
 Since nearly every response from the Spotify Web API returns some sort of JSON data, decoding these bags-o-bits is essential to bringing the Spotify catalog to your Swift applications. With the introduction of the Encoding & Decoding APIs in the Swift 4 [Standard Library](apple-reference-documentation://ts2902609) and Xcode 9 [SDK](apple-reference-documentation://ts2877770), parsing JSON payloads has become relatively painless. On this page, you'll see how **SpotifyKit** makes this process even easier for you by introducing some simple protocols along with the framework.
 
 ## JSONCodable Protocols
 **SpotifyKit** includes two supporting protocols, `JSONDecodable` and `JSONEncodable`, that inherit from the existing [`Decodable`](apple-reference-documentation://hs4cSpS_o7) and [`Encodable`](apple-reference-documentation://hsdjwRFzpr) protocols, respectively.
 */

import SpotifyKit
import Foundation

//: ## Decoding JSON Data
//: ### JSONDecodable Protocol
//: (list the StdLib & Foundation types that conform to it + all top-level model structs)
//: (illustrate decoding in `perform` method)

//: ## Encoding JSON Data
//: ### JSONEncodable Protocol
//: (illustrate example where responses are encoded... like the playlist example from earlier)

//: ***
//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
