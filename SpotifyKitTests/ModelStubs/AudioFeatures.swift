//
//  AudioFeatures.swift
//  SpotifyKitTests
//
//  Created by Alexander Havermale on 7/24/17.
//  Copyright © 2018 Alex Havermale.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

let audioFeaturesData = """
{
  "danceability" : 0.770,
  "energy" : 0.787,
  "key" : 10,
  "loudness" : -4.402,
  "mode" : 0,
  "speechiness" : 0.113,
  "acousticness" : 0.0482,
  "instrumentalness" : 0,
  "liveness" : 0.108,
  "valence" : 0.696,
  "tempo" : 125.013,
  "type" : "audio_features",
  "id" : "6VRghJeP6I0w1KxkdWFfIh",
  "uri" : "spotify:track:6VRghJeP6I0w1KxkdWFfIh",
  "track_href" : "https://api.spotify.com/v1/tracks/6VRghJeP6I0w1KxkdWFfIh",
  "analysis_url" : "https://api.spotify.com/v1/audio-analysis/6VRghJeP6I0w1KxkdWFfIh",
  "duration_ms" : 203782,
  "time_signature" : 4
}
""".data(using: .utf8)!
