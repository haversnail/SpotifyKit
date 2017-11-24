//
//  URL+RemoveQuery.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/12/17.
//  Copyright © 2017 Alex Havermale.
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

extension URL {
    
    /// Returns a URL constructed by removing any query.
    ///
    /// If the URL has no query (e.g., `http://www.example.com`), then this function will return the URL unchanged.
    internal func deletingQuery() -> URL {
        if query == nil { return self }
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.query = nil
        return components?.url ?? self
    }
    
    /// Reconstructs the URL after removing any query.
    ///
    /// If the URL has no query (e.g., `http://www.example.com`), then this function will do nothing.
    internal mutating func deleteQuery() {
        if query == nil { return }
        self = deletingQuery()
    }
}
