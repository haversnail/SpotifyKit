/*:
 ![Logo](Logo.png)
 # SpotifyKit Playgrounds
 ***
 
 ## Table of Contents
 - [Making API Requests](Making%20API%20Requests)
 - [Decoding Responses](Decoding%20Responses)
 - [Pagination](Pagination)
 - [`SKCatalog` & Other Request Factories](Request%20Factories)
 - [SDK Integration](SDK%20Integration)
 - [LICENSE](LICENSE)
 
 - Important:
    ## Before using this Playground:
    1. Using [Carthage](https://github.com/Carthage/Carthage), check out the [Spotify iOS SDK](https://github.com/spotify/ios-sdk) dependency (if you haven't already) by running `carthage bootstrap --no-build` from the repo's root directory.
    2. Open `SpotifyKit.xcworkspace`.
    3. Build the current scheme (**"Product" > "Build"** or **⌘B**).
    4. Grab a valid Web API Access Token [here](https://developer.spotify.com/web-api/console/get-current-user/token?scope=user-read-private&scope=user-read-birthdate&scope=user-read-email&scope=playlist-read-private&scope=playlist-read-collaborative&scope=playlist-modify-public&scope=playlist-modify-private&scope=user-library-read&scope=user-library-modify&scope=user-follow-read&scope=user-follow-modify&scope=user-top-read&scope=user-read-playback-state&scope=user-read-recently-played&scope=user-read-currently-playing&scope=user-modify-playback-state&scope=ugc-image-upload). (P.S. - it's only good for an hour.)
    5. Open `Setup.swift` in the playground's **Sources** folder.
    6. Paste your Spotify Premium account username and shiny new access token in the placeholders.
    7. You're good to go! 👍
 */

import SpotifyKit
import Foundation

//: [Next](@next)
