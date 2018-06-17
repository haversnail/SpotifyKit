# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
- *Any untagged changes will be listed here.*

## [1.1.0] - 2018-06-17
### Added
- A standalone web-based mechanism for retrieving temporary access tokens from the [Spotify Web API][Web API] when using the SpotifyKit playground or running the framework's unit tests, hosted on SpotifyKit's [GitHub Pages][Token].

### Changed
- Updated the framework to use Swift 4.1. Specifically:
    - Refactored the `JSONDecodable`, `JSONEncodable`, and `URLEncodable` extensions using [conditional conformances](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md).
    - Replaced any deprecated symbols with their Swift 4.1 equivalent (e.g., `flatMap` → `compactMap`).
- Renamed the cursor properties `latest`/`earliest` to `newest`/`oldest` to improve clarity.
- Modified the design of the [documentation][Docs] pages and refactored the `/docs` directory.
- Updated all the [developer.spotify.com](https://developer.spotify.com) hyperlinks to reflect the new site.
- Updated the README with better visuals and an improved roadmap.
- Updated the build environment for Xcode 9.4.

### Fixed
- Embeds the `Cursors` type within the `CursorPage` struct as originally designed (now that [SR-5086](https://bugs.swift.org/browse/SR-5086) has been resolved in Swift 4.1), enabling the compilation of page cursors as concrete types.

## [1.0.1] - 2017-12-30
### Added
- Incorporated [Travis CI](https://travis-ci.org/haversnail/SpotifyKit) into the project.

### Changed
- Updated the README content.

### Fixed
- A `URLEncodable` bug that kept the project from compiling.

## 1.0.0 - 2017-10-26
This is the first public release of the SpotifyKit framework. As such, the following changes outline all the notable differences and design deviations between SpotifyKit and the [Spotify Web API][Web API]. All changes have been carefully considered and are intended to better standardize SpotifyKit and conform its model and methods to match [Swift design convention][Guidelines].

### Added
- An `SKRequest` class for preparing and sending URL requests to the [Web API].
- JSON Encoding and Decoding mechanisms for the API [Object Model].
- An `SKCatalog` struct that functions as a request factory for locale-dependent endpoints.
- An `SKPlayer` struct that functions as a request factory for the [Web API Connect](https://developer.spotify.com/documentation/web-api/guides/using-connect-web-api/) endpoints.
- An `SKSearchResults` struct for the [Search](https://developer.spotify.com/documentation/web-api/reference/search/search/) endpoint response.
- An `SKFeaturedPlaylists` struct for the "[Get Featured Playlists](https://developer.spotify.com/documentation/web-api/reference/browse/get-list-featured-playlists/)" endpoint response.
- Various enumeration types to support other endpoint requests.
- Extensions to symbols in the `SpotifyAuthentication` and `SpotifyAudioPlayback` [iOS SDK] frameworks.

### Changed
- **Object Model:**
    - Renamed [Paging](https://developer.spotify.com/documentation/web-api/reference/object-model/#paging-object) and [Cursor-Based Paging](https://developer.spotify.com/documentation/web-api/reference/object-model/#cursor-based-paging-object) objects to `Page` and `CursorPage`, respectively. These types function as [`Collections`](https://developer.apple.com/documentation/swift/collection).
    - Renamed [Private User](https://developer.spotify.com/documentation/web-api/reference/object-model/#user-object-private) objects to `SKCurrentUser`. This type also functions as a request factory for endpoints that are restricted to the current authenticated user.
    - Renamed [Play History](https://developer.spotify.com/documentation/web-api/reference/object-model/#play-history-object) objects to `SKRecentTrack`.
    - Renamed beta [Currently Playing](https://developer.spotify.com/documentation/web-api/reference/player/get-information-about-the-users-current-playback/) objects to `SKPlaybackState`.
    - Refactored [Cursor](https://developer.spotify.com/documentation/web-api/reference/object-model/#cursor-object) objects as embedded structs with a generic cursor type that depends on the type of elements in the paging collection.
    - Decodes objects without fixed key names or with a variable or number of keys (i.e., [External ID](https://developer.spotify.com/documentation/web-api/reference/object-model/#external-id-object) objects, [External URL](https://developer.spotify.com/documentation/web-api/reference/object-model/#external-url-object) objects, etc.) as `[String : String]` or `[String : URL]` dictionary objects.
    - Represents objects with both a "simplified" and "full" version as one type, with an optional set of properties for any simplified instances. See the `Expandable` protocol in the [documentation][Docs] for more details.

- **Object Properties:**
    - Changed standardized string attributes to enumeration types (e.g., `SKAlbumType`, `SKDatePrecision`, etc.).
    - Renamed all `href` attributes to `url`.
    - Renamed properties whose names originally ended in prepositions (e.g., `added_at`, `linked_from`, etc.) to descriptive names read as nouns (e.g., `dateAdded`, `trackLinks`, etc.).
    - Prefixed all Boolean properties with a linking verb (e.g. “is,” “has,” etc.) asserting the condition about the given object.
    - Converted all strings representing dates or timestamps to a formatted `Date` type, each with their respective level of precision.
    - Standardized all `duration` properties as `TimeInterval` types, converting values to seconds (maintaining millisecond precision).

### Removed
- The `type` attribute from the following model types *(used as a privately-scoped property to verify the object during decoding instead)*:
    - `SKAlbum`
    - `SKArtist`
    - `SKAudioFeatures`
    - `SKPlaylist`
    - `SKTrack`
    - `SKTrackLinks`
    - `SKUser`
    - `SKCurrentUser`

- Does not include request methods for any [Web API Connect](https://developer.spotify.com/documentation/web-api/guides/using-connect-web-api/) endpoints that control playback; this is already handled by the `SpotifyAudioPlayback` framework.

[Unreleased]: https://github.com/haversnail/SpotifyKit/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/haversnail/SpotifyKit/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/haversnail/SpotifyKit/compare/v1.0.0...v1.0.1

[Docs]: https://haversnail.github.io/SpotifyKit/documentation/
[Token]: https://haversnail.github.io/SpotifyKit/token/
[iOS SDK]: https://github.com/spotify/ios-sdk
[Web API]: https://developer.spotify.com/documentation/web-api/
[Object Model]: https://developer.spotify.com/documentation/web-api/reference/object-model/
[Guidelines]: https://swift.org/documentation/api-design-guidelines/
