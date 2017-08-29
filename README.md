![Logo](Logo/SpotifyKit.png)
# ⏤ SpotifyKit ⏤
A complete [Spotify Web API][API] and [iOS SDK][SDK] bundle, tailored for Swift.

[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg "Swift version")][Swift]
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg "Carthage compatible")][Carthage]
[![SDK](https://img.shields.io/badge/SDK-beta--25-blue.svg "Spotify iOS SDK release")][SDK]
![platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg "platforms")

## Getting Started

#### "Why Should I Use This?"

##### The entire Spotify catalog, at your disposal.
* **SpotifyKit** is a [Spotify Web API][API] [Object Model][OM] wrapper with *value-type semantics* that adheres to the Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/), providing streamlined interoperability between your Swift app and the Spotify catalog.

##### Compatible with Spotify's [iOS SDK][SDK].
* In addition to accessing library content, **SpotifyKit** plays nicely with the official [iOS SDK][SDK], providing extensions and convenience methods for using SpotifyKit objects with the Audio Playback and Authentication interface.

##### Integrate with ease.
* **SpotifyKit** also streamlines the inclusion of the [iOS SDK][SDK]'s pre-compiled frameworks in your Swift application: just embed the dependencies into your project, include `SpotifyKit` in your code, and you're good to go. No bridging headers or frustrating [compatibility issues](https://github.com/spotify/ios-sdk/issues/811) to deal with.

## Installation

> ⚠️ **Important:** This framework currently only supports an iOS deployment target of 10.3 or higher.

#### Carthage

If you use [Carthage][Carthage] to manage your project's dependencies, add the following line to your `Cartfile`:
```bash
github "ahavermale/spotifykit" ~> 1.0
```
and run `carthage update` to check out and build **SpotifyKit** and its dependencies.

> As a dependency, Carthage will attempt to build the `spotify/ios-sdk` repository. Since their repository does not contain a buildable Xcode project for these frameworks, but rather pre-compiled binaries, **expect Carthage to generate an error during the build process.** It will not affect installation.

After the **SpotifyKit** framework has been built, follow the rest of the Carthage [installation steps](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos) and make sure you've linked the following frameworks to your project, taking note of where the different binaries are located:

| Framework                         | Path                              |
| --------------------------------- | --------------------------------- |
| `SpotifyKit.framework`            | `Carthage/Build/iOS/SpotifyKit/`  |
| `SpotifyAudioPlayback.framework`  | `Carthage/Checkouts/ios-sdk/`     |
| `SpotifyAuthentication.framework` | `Carthage/Checkouts/ios-sdk/`     |

And don't forget to link the `AVFoundation.framework` if you intend to use the Spotify Audio Playback interface.

#### CocoaPods

#### Manual Setup

1. Check out or download the **SpotifyKit** repository.

2. Using [Carthage][Carthage], run `carthage bootstrap --no-build` from the repo's root directory. This will check out the [Spotify iOS SDK][SDK] dependency, without attempting to build the already-built framework binaries.

    * If for some reason you cannot use Carthage, you could download the contents of the [SDK][SDK] yourself, so long as those contents are copied to `Carthage/Checkouts/ios-sdk/` from the SpotifyKit root directory.

3. From the repo's root directory, run the following commands:
```bash
chmod +x modulemaps.sh
./modulemaps.sh
```
    This creates module maps for the newly checked-out [iOS SDK][SDK] frameworks, which should eliminate any initial "missing module" errors encountered in the Xcode project.

4. Open the Xcode project and select **"Product" > "Build" (⌘B)**. Voilà.

> #### A Note on Module Maps
> Unfortunately, as of their `beta-25` release, Spotify's pre-compiled [iOS SDK][SDK] frameworks have not been built as importable modules (i.e., their `DEFINES_MODULE` build setting was not set), which prevents Swift targets from using them out-of-the-box. However, **SpotifyKit** provides a fix-it by checking for and creating module maps for each framework before each build by running the `modulemaps.sh` script. As explained above, you can run this script yourself if you come across any "missing module" errors while working with the [SDK][SDK]'s frameworks.
>
> Alternatively, you can manually create these module maps by browsing to the respective `.framework` file, creating a `Modules` folder, and within that folder, creating a file called `module.modulemap` with the following contents:

```swift
framework module SpotifyAudioPlayback {
    umbrella header "SpotifyAudioPlayback.h"

    export *
    module * { export * }
}
```

## Usage

### Examples

## Significant API Changes
Any notable differences and deviations between **SpotifyKit** and the [Spotify Web API][API] are listed below. All changes have been carefully considered and are intended to better standardize **SpotifyKit** and conform its model and methods to match Apple/Swift convention.
#### Model Changes
* __*Object types:*__
    * **[Paging object][OM-paging]** → "`PagedCollection`," a generic structure that's strongly typed with the kind of objects it contains, containing properties for both [offset-based][OM-paging] and [cursor-based][OM-cursor-paging] paging.

        * `PagedCollection` also conforms to the Swift Standard Library’s `Collection` protocol, forwarding all the functionality of the underlying collection of items to the paging structure itself.

    * **[Saved Track][OM-saved-track]/[Saved Album][OM-saved-album] objects** → "`SavedItem`," a generic structure that's strongly typed with the kind of saved item it contains. Compatible types like Albums and Tracks conform to the `UserSavable` protocol, which ensures that the compiler will warn you ahead-of-time if you provide a media type that Spotify hasn’t (yet) made savable by the user.

    * Objects in the [Object Model][API] that do not have fixed key names or that have a variable or number of keys are decoded as `[String : *]` dictionary objects (e.g., [External ID object][OM-external-id], [External URL object][OM-external-url], etc.).

    * Embedded struct types for simple API objects (e.g., [Copyright object][OM-copyright], [Track Link object][OM-track-link], etc.).

    * Embedded enum types for standardized `String` values (e.g., Album types, Date precision, etc.).

* __*Object properties:*__
    * Renamed all `href` → `url`.

    * Properties whose names originally ended in prepositions (e.g., `added_at`, `linked_from`, etc.) are given more descriptive names read as nouns (e.g., `dateAdded`, `trackLinks`, etc.).

    * All Boolean properties are prefixed by a linking verb (e.g. “is,” “has,” etc.) asserting the condition about the given object.

    * Where appropriate, all strings representing dates or timestamps are converted to a formatted `Date` type, each with their respective level of precision.

    * All `duration` properties are standardized as `TimeInterval` types and converted to seconds (maintaining millisecond precision).

#### Additions

* __*Object properties:*__

    * _**TODO**: Simplified Playlist properties._

* __*Object extensions:*__

    * All objects that are represented by both "simplified" and "full" versions in the [Web API][API] conform to the `Expandable` protocol, which provides a method for fetching and returning the more detailed version of the simplified object.

* __*SDK extensions:*__

    * [**SPTSession**](https://spotify.github.io/ios-sdk/Classes/SPTSession.html) includes convenience methods for making API requests, encapsulating an `SKRequest` instance and providing a callback handler for the response.

    * _**TODO**: Existing SDK object extensions._

#### Deletions

* __*Object properties:*__
    * For the **SpotifyKit** types listed below, there is no public property for the corresponding JSON object's `type` attribute. Instead, these types implement a private `type` property that uses a single-case enumeration to assert that the attribute's value exactly matches what's expected for this kind of **SpotifyKit** type (see code snippet below). For example, with types like `SKArtist` and `SKUser`, whose only non-optional properties match those found in other **SpotifyKit** types, one could mistakenly decode an [album object][OM-album-simplified] payload as an `SKArtist` or `SKUser` without ever encountering an error. Including this enum mechanism not only ensures that cases like this will throw, but also reduces boilerplate code and eliminates the need to manually define an already-synthesized initializer just to verify the type.

        * `SKAlbum` ([Simplified][OM-album-simplified] / [Full][OM-album-full])
        * `SKArtist` ([Simplified][OM-artist-simplified] / [Full][OM-artist-full])
        * `SKAudioFeatures`
        * `SKPlaylist` ([Simplified][OM-playlist-simplified] / [Full][OM-playlist-full])
        * `SKTrack` ([Simplified][OM-track-simplified] / [Full][OM-track-full] / [Track Link][OM-track-link])
        * `SKUser` ([Public][OM-user-public] / [Private][OM-user-private])

    * The *"`type`"* property in action:

```swift
public struct SKAlbum: JSONCodable {

    // An enum representing the expected `type` value for an album object.
    private enum ObjectType: String, Codable { case album }

    private let type: ObjectType

    // ...
}
```

## Roadmap

##### Current stable release:
![release](https://img.shields.io/badge/release-v1.0.0-blue.svg "Current stable release")

##### Pending Swift 4 final release:
- [ ] *[Conditional conformance](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md)* → extending `JSONCodable` and `Equatable` protocols.
    - This feature would allow for things like:

```swift
extension Array: JSONCodable where Element: JSONCodable {
    // Conforming Arrays to JSONCodable where its Elements are.
}
```

or:

```swift
extension PagedCollection: Equatable where Object: Equatable {
    // Conforming PagedCollection to Equatable where its Objects are.
}
```

## Contributing

## Credits

### Who do I talk to?

## License

[API]: https://developer.spotify.com/web-api/
[SDK]: https://github.com/spotify/ios-sdk
[Swift]: https://swift.org
[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[OM]: https://developer.spotify.com/web-api/object-model/
[OM-album-simplified]: https://developer.spotify.com/web-api/object-model/#album-object-simplified
[OM-album-full]: https://developer.spotify.com/web-api/object-model/#album-object-full
[OM-artist-simplified]: https://developer.spotify.com/web-api/object-model/#artist-object-simplified
[OM-artist-full]: https://developer.spotify.com/web-api/object-model/#artist-object-full
[OM-audio-features]: https://developer.spotify.com/web-api/object-model/#audio-features-object
[OM-copyright]: https://developer.spotify.com/web-api/object-model/#copyright-object
[OM-external-id]: https://developer.spotify.com/web-api/object-model/#external-id-object
[OM-external-url]: https://developer.spotify.com/web-api/object-model/#external-url-object
[OM-paging]: https://developer.spotify.com/web-api/object-model/#paging-object
[OM-cursor-paging]: https://developer.spotify.com/web-api/object-model/#cursor-based-paging-object
[OM-playlist-simplified]: https://developer.spotify.com/web-api/object-model/#playlist-object-simplified
[OM-playlist-full]: https://developer.spotify.com/web-api/object-model/#playlist-object-full
[OM-saved-track]: https://developer.spotify.com/web-api/object-model/#saved-track-object
[OM-saved-album]: https://developer.spotify.com/web-api/object-model/#saved-album-object
[OM-track-simplified]: https://developer.spotify.com/web-api/object-model/#track-object-simplified
[OM-track-full]: https://developer.spotify.com/web-api/object-model/#track-object-full
[OM-track-link]: https://developer.spotify.com/web-api/object-model/#track-link
[OM-user-private]: https://developer.spotify.com/web-api/object-model/#user-object-private
[OM-user-public]: https://developer.spotify.com/web-api/object-model/#user-object-public
