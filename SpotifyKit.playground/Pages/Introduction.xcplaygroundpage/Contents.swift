/*:
 ![Logo](Logo.png)
 # SpotifyKit Playgrounds
 ***
 
 ## Table of Contents
 - [Making API Requests](Making%20API%20Requests)
 - [Decoding Responses](Decoding%20Responses)
 - [`SKCatalog` & Other Request Factories](Request%20Factories)
 - [Pagination](Pagination)
 - [Spotify iOS SDK Integration](SDK%20Integration)
 - [LICENSE](LICENSE)
 
 - Important:
    ## Before using this Playground:
    1. Using [Carthage](https://github.com/Carthage/Carthage), check out the [Spotify iOS SDK](https://github.com/spotify/ios-sdk) dependency (if you haven't already) by running `carthage bootstrap --no-build` from the repo's root directory.
    2. Open `SpotifyKit.xcworkspace`.
    3. Build the current scheme (**"Product" > "Build"** or **⌘B**).
    4. Grab a valid Web API Access Token [here](https://accounts.spotify.com/authorize?response_type=token&redirect_uri=https%3A%2F%2Fhaversnail.github.io%2FSpotifyKit%2Ftoken%2F&client_id=6dfb2743f2744068ba258276d673ef54&scope=user-read-private+user-read-email+user-read-birthdate+playlist-read-private+user-library-modify+playlist-read-collaborative+playlist-modify-private+user-follow-modify+user-read-currently-playing+user-read-recently-played+user-library-read+user-top-read+playlist-modify-public+user-follow-read+user-read-playback-state+user-modify-playback-state+ugc-image-upload+streaming). (P.S. - it's only good for an hour.)
    5. Open `Setup.swift` in the playground's **Sources** folder.
    6. Paste your Spotify Premium account username and shiny new access token in the placeholders.
    7. You're good to go! 👍
 */

import SpotifyKit
import Foundation

//: [Next](@next)
