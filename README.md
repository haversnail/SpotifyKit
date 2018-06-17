![Logo](Logo/SpotifyKit.png)
An intuitive and comprehensive Swift framework for the [Spotify Web API][Web API].

[![Swift](https://img.shields.io/badge/Swift-4.1-orange.svg "Swift version")][Swift]
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg "Carthage compatible")][Carthage]
[![iOS SDK](https://img.shields.io/badge/iOS%20SDK-beta--25-blue.svg "Spotify iOS SDK release")][iOS SDK]
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg "Platforms")
[![Docs](docs/documentation/badge.svg "Documentation coverage")][Docs]
[![Build](https://travis-ci.org/haversnail/SpotifyKit.svg?branch=master "latest build on master branch")][Travis CI]

## Getting Started

#### "Why Should I Use This?"

##### The entire Spotify catalog, at your disposal.
* **SpotifyKit** is a *protocol-oriented*, *value-type* [Spotify Web API][Web API] wrapper that adheres to the Swift [API Design Guidelines][Guidelines], providing streamlined interoperability between your Swift app and the entire Spotify catalog.

##### Compatible with Spotify's [iOS SDK][iOS SDK].
* In addition to accessing catalog content, SpotifyKit plays nicely with the Spotify [iOS SDK][iOS SDK], providing extensions and convenience methods for using SpotifyKit types with the Audio Playback and Authentication interface.

##### Integrate with ease.
* SpotifyKit also streamlines the inclusion of the [iOS SDK][iOS SDK] frameworks in your Swift application: just embed the dependencies into your project, include `SpotifyKit` in your code, and you're good to go. No Objective-C, bridging headers, or frustrating [compatibility issues][SDK-issue-811] to deal with.

## Installation

> ⚠️ **Important:** This framework currently only supports an iOS deployment target of 10.3 or higher.

#### Carthage

If you use [Carthage][Carthage] to manage your project's dependencies, add the following line to your `Cartfile`:
```bash
github "haversnail/SpotifyKit" ~> 1.1
```
and run `carthage update` to check out and build SpotifyKit and its dependencies.

> Note that since the `spotify/ios-sdk` repository contains pre-compiled binaries instead of a buildable Xcode project, Carthage will skip the build process for this dependency.

Once the build process is finished, follow the rest of the Carthage [installation steps](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos) and make sure you've linked the following frameworks to your project, taking note of where the different binaries are located:

| Framework                         | Path                              |
| --------------------------------- | --------------------------------- |
| `SpotifyKit.framework`            | `Carthage/Build/iOS/SpotifyKit/`  |
| `SpotifyAudioPlayback.framework`  | `Carthage/Checkouts/ios-sdk/`     |
| `SpotifyAuthentication.framework` | `Carthage/Checkouts/ios-sdk/`     |

And don't forget to link the `AVFoundation.framework` if you intend to use the Spotify Audio Playback interface.

#### CocoaPods

✨ *Coming soon to a repository near you!* ✨

#### Manual Setup

1. Check out or download the `haversnail/SpotifyKit` repository.

2. Using [Carthage][Carthage], run `carthage bootstrap --no-build` from the repo's root directory. This will check out the [iOS SDK][iOS SDK] dependency without attempting to build the already-built framework binaries.

* If for some reason you cannot use Carthage, you could download the contents of the SDK yourself, so long as those contents are copied to `Carthage/Checkouts/ios-sdk/` from the SpotifyKit root directory.

3. From the repo's root directory, run the following commands:
```bash
chmod +x modulemaps.sh
./modulemaps.sh
```
This creates module maps for the newly checked-out frameworks, which should eliminate any initial "missing module" errors encountered in the Xcode project.

4. Open the Xcode project and select **"Product" > "Build"** or press <kbd>⌘</kbd> + <kbd>B</kbd>. You're good to go! 👍

> ### A Note on Module Maps
> As of the `beta-25` release, Spotify's pre-compiled iOS SDK frameworks [have not been built as importable modules][SDK-issue-811], which prevents Swift targets from using them out-of-the-box. However, SpotifyKit fixes this by checking for and creating module maps for each framework by running the `modulemaps.sh` script before each build. As explained above, you can run this script yourself if you come across any "missing module" errors while working with the frameworks.
>
> Alternatively, you can manually create these module maps by browsing to the respective `.framework` file, creating a `Modules` folder, and within that folder, creating a file called `module.modulemap` with the following contents:
>
> ```swift
> framework module SpotifyAudioPlayback {         // or `SpotifyAuthentication`
>     umbrella header "SpotifyAudioPlayback.h"    // ditto
>     
>     export *
>     module * { export * }
> }
> ```

## Usage

### Examples

- 🛠 Check out the Xcode Playground for a detailed walkthrough of the SpotifyKit framework.

![Playground](Screenshots/Playground-Screenshot.png)

### Documentation

- 📖 Read the full SpotifyKit documentation [here][Docs], courtesy of [Jazzy](https://github.com/realm/jazzy).

![Docs](Screenshots/Docs-Screenshot.png)

## Roadmap

#### Current stable release:
![release](https://img.shields.io/github/release/haversnail/SpotifyKit.svg "Current stable release")

#### Pending future release:

- [ ] Add  [`Equatable`](https://developer.apple.com/documentation/swift/equatable) conformance to all SpotifyKit value types *(waiting on complete implementation of [synthesizing Equatable and Hashable conformance](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md) in Swift 4.2 to ship with Xcode)*.

    - This would allow for something like:

    ```swift
    public struct Page<Element>: OffsetPagingCollection {
        // ...
    }

    // Implementation can be synthesized at build time in Swift 4.2:
    extension Page: Equatable where Element: Equatable {}
    ```

- [ ] Remove the `all` property from `SKSearchResultType` and instead conform it to the new `CaseIterable` protocol in Swift 4.2.

- [ ] Add Audio Analysis type and related request methods.

- [ ] Consider removing iOS SDK dependencies and migrating to an alternative authentication mechanism (cf. [*SpotifyLogin*](https://github.com/spotify/SpotifyLogin)) for those wanting commercial use.

- [ ] As pointed out by @slashmo, consider abstracting away the networking component into a separate framework/dependency altogether.

## Contributing

📋 See the [contribution guidelines](CONTRIBUTING.md).

## Credits

✌️ **SpotifyKit** was created by [Alex Havermale](mailto:alex.havermale@icloud.com).

## License

⚖️ See [LICENSE](LICENSE.txt) for more details.

[Docs]: https://haversnail.github.io/SpotifyKit/documentation/
[Web API]: https://developer.spotify.com/documentation/web-api/
[iOS SDK]: https://github.com/spotify/ios-sdk
[Swift]: https://swift.org
[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/
[Guidelines]: https://swift.org/documentation/api-design-guidelines/
[Travis CI]: https://travis-ci.org/haversnail/SpotifyKit

[SDK-issue-811]: https://github.com/spotify/ios-sdk/issues/811
