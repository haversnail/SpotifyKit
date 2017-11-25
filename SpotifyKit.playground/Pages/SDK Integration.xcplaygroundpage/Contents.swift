/*:
 [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
 ***
 
 # Spotify iOS SDK Integration
 > ### Running this playground will begin audio playback—make sure your speakers are ready! 🔇🔊
 */
/// A Spotify client ID to use for the Playground's audio streaming controller.
let clientID = "<#Your App's Client ID#>"
/*:
 While its primary purpose is providing a Swift wrapper for the [Web API](https://developer.spotify.com/web-api/), **SpotifyKit** also aims to assist in integrating the [Spotify iOS SDK](https://github.com/spotify/ios-sdk) into your project as well. With a little magic and some Swift extensions, it streamlines the inclusion of Spotify's authentication and audio playback frameworks, and adds convenience methods to existing iOS SDK types for compatibility and interoperatbility.
 
 ## Module Availability
 As you've seen throughout these playground pages, importing `SpotifyKit` in your code allows access to all the symbols declared in the `SpotifyAuthentication` and `SpotifyAudioPlayback` frameworks:
 */

import SpotifyKit

SPTAuth.defaultInstance().session = SPTSession(userName: username, accessToken: accessToken, expirationDate: Date.distantFuture)

//: - Important: In order for this to work correctly, it's important that the `SpotifyKit` module be built using the current scheme. Check out the README's [note on module maps](../README.md#a-note-on-module-maps) for more details.

/*:
 ## Authentication
 As mentioned in [Making API Requests](Making%20API%20Requests), the `SKRequest` class uses an [`SPTSession`](https://spotify.github.io/ios-sdk/Classes/SPTSession.html) instance to authenticate its underlying URL request. Although custom session objects would normally be assigned after the creation of a request, **SpotifyKit** also adds the flexibility to create a request directly from the session object itself.
 */

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let session = SPTAuth.defaultInstance().session!
let authorizedRequest = session.makeRequest(method: .GET, endpoint: "/v1/artists/6YWdHD3R863Apw1hkx3BwC")

/*:
 ## Audio Playback
 At the end of the day, what good would all this be if you can't play anything? 🤔
 
 **SpotifyKit** also attempts to provide interoperability with the [`SPTAudioStreamingController`](https://spotify.github.io/ios-sdk/Classes/SPTAudioStreamingController.html) class as well, adding to it a set of playback and queueing methods that take **SpotifyKit** types as arguments. As you'll see (and hear) below, we now have a `play` method on our player instance which, in this example, takes any type that conforms to the `Album` protocol, and optionally, the index of the track with which we want to begin playback:
 */

let player = SPTAudioStreamingController.sharedInstance()!
try? player.start(withClientId: clientID)
player.login(withAccessToken: accessToken)

sleep(5) // Gotta wait a second (or five) for the player to login...

SKCatalog.local.getAlbum(withID: "5DLhV9yOvZ7IxVmljMXtNm") { [unowned player] (album, error) in
    
    if let album = album {
        // Plays the album, starting at the third track (or rather, the track at index "2"):
        player.play(album, at: 2) { (error) in
            // Any errors encountered attempting playback are provided here.
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

sleep(10)

//: Alternatively, **SpotifyKit** also makes this functionality available as a method on the values themselves:

SKCatalog.local.getTrack(withID: "1aJtyIMev4kW8IMUxOjn1Y") { (track, error) in
    
    track?.queue { (error) in
        // Got errors? Handle 'em here!
    }
}

/*:
 ## The Road Ahead
 As Spotify continues to expand upon their developer resources and platform SDKs, **SpotifyKit** will also aim to stay relevant with what's available. In the meantime, you should check out their [beta website](https://beta.developer.spotify.com/) for developers—if **SpotifyKit** doesn't suit your app's specific needs, perhaps there you'll find something that can!
 
 You can check out the detailed roadmap for **SpotifyKit** in the [README](README.md).
 */
//: ***
//: [Table of Contents](Introduction) | [Previous](@previous) | [Next](@next)
