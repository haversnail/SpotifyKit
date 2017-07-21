![Logo](Logo/SpotifyKit.png)
# ⏤ SpotifyKit ⏤
A complete [Spotify Web API][API] and [iOS SDK][SDK] bundle, tailored for Swift.

[API]: https://developer.spotify.com/web-api/
[SDK]: https://github.com/spotify/ios-sdk

[![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg "Swift version")](https://swift.org)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg "Carthage compatible")](https://github.com/Carthage/Carthage)
[![SDK](https://img.shields.io/badge/SDK-beta--25-blue.svg "Spotify iOS SDK release")](https://github.com/spotify/ios-sdk)
![platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg "platforms")

## Getting Started

#### Why Should I Use This?
**SpotifyKit** provides a Swift-esque, *value-type semantic* [Spotify Web API][API] Object Model wrapper that adheres to the Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/), providing streamlined interoperability between your app and the Spotify library.

**SpotifyKit** also streamlines the inclusion of the [Spotify iOS SDK][SDK] **Audio Playback** and **Authentication** frameworks, and provides extensions and convenience methods for using SpotifyKit objects with the SDK interface.

## Installation

> ⚠️ **Important:** This framework currently only supports iOS 11 deployment targets.

### Dependencies

#### Carthage

### Configuration

#### Module Maps

Unfortunately, as of their `beta-25` release, Spotify's pre-packaged [iOS SDK][SDK] frameworks have not been built as importable modules (i.e., their `DEFINES_MODULE` build setting had not been enabled), which prevents Swift target applications from using them out-of-the-box. However, **SpotifyKit** provides a fix-it by checking for and/or creating module maps for each framework before building the project. They look something like this:
```swift
framework module SpotifyAudioPlayback {
    umbrella header "SpotifyAudioPlayback.h"

    export *
    module * { export * }
}
```
In order for Swift to recognize these frameworks, simply perform an initial build (⌘B) of the project; otherwise, any related `import` statement will generate an error.

Alternatively, you can run the module-map-making script yourself from the command line by executing the `modulemaps.sh` script from the source root directory:
```bash
chmod +x modulemaps.sh
./modulemaps.sh
```
## Usage

### Examples

## Contributing

## Credits

### Who do I talk to?

## License
