//
//  URL+RemoveQuery.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/12/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
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
