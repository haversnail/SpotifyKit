![Logo](Logo/SpotifyKit.png)
# ⏤ SpotifyKit ⏤
A complete [Spotify Web API][API] and [iOS SDK][SDK] bundle, tailored for Swift.

[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg "Swift version")][Swift]
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg "Carthage compatible")][Carthage]
[![SDK](https://img.shields.io/badge/SDK-beta--25-blue.svg "Spotify iOS SDK release")][SDK]
![platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg "platforms")

## Getting Started

#### "Why Should I Use This?"

##### The entire [Spotify library](https://developer.spotify.com/web-api/object-model/), at your disposal.
* **SpotifyKit** is a [Spotify Web API][API] Object Model wrapper with *value-type semantics* that adheres to the Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/), providing streamlined interoperability between your Swift app and the Spotify library.

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

After the **SpotifyKit** framework has been built, follow the rest of the [installation steps](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos) and make sure you've linked the following frameworks to your project, taking note of where the different binaries are located:

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
    * This creates module maps for the newly checked-out [iOS SDK][SDK] frameworks, which should eliminate any initial "missing module" errors encountered in the Xcode project.

4. Open the Xcode project select **"Product" > "Build" (⌘B)**. Voilà.

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

## Contributing

## Credits

### Who do I talk to?

## License

[API]: https://developer.spotify.com/web-api/
[SDK]: https://github.com/spotify/ios-sdk
[Swift]: https://swift.org
[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/
