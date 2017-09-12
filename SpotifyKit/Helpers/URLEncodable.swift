//
//  URLEncodable.swift
//  SpotifyKit
//
//  Created by Alexander Havermale on 8/13/17.
//  Copyright © 2017 Alex Havermale. All rights reserved.
//

import Foundation

internal protocol URLEncodable {
    func urlEncodedString(using encoder: URLEncoder) -> String
}

internal class URLEncoder {
    
    internal static var `default` = URLEncoder() // shared
    
    internal var listSeparator: String = ","
    internal var spaceSeparator: String = "+"
    internal var rangeSeparator: String = "-"
    
    internal var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // Doesn't include the "Z" literal, apparently.
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    internal var timeIntervalPrecision: TimeIntervalPrecision = .milliseconds
    
    internal enum TimeIntervalPrecision {
        case seconds        // Keeps a TimeInterval value, stored as seconds, in the same format.
        case milliseconds   //Converts a TimeInterval value, stored as seconds, to milliseconds.
    }
    
    internal func encode<T: URLEncodable>(_ value: T) -> String {
        return value.urlEncodedString(using: self)
    }
    
    // Arrays: separated by ","
    // String w/ spaces: separated by "+"
    // "Fields" field? (see playlist)
    // Ints
    // Dates: "2014-10-23T09:00:00"
    // TimeInterval -> ms
}

extension String: URLEncodable {
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        return self.replacingOccurrences(of: " ", with: encoder.spaceSeparator)
    }
}

extension Date: URLEncodable {
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        return encoder.dateFormatter.string(from: self)
    }
}

extension URLEncodable where Self: LosslessStringConvertible { // Bool/Double/Float/Float80/Substring/Unicode.Scalar
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        return String(self).replacingOccurrences(of: " ", with: encoder.spaceSeparator) // For substrings that contain spaces.
    }
}

extension Bool: URLEncodable {}
//extension Double: URLEncodable {}
extension Float: URLEncodable {}
extension Float80: URLEncodable {}
extension Substring: URLEncodable {}

extension URLEncodable where Self: FixedWidthInteger { // DoubleWidth/Int/Int*/UInt/UInt*
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        return "\(self)" //String(self)
    }
}

extension Int: URLEncodable {}
extension Int8: URLEncodable {}
extension Int16: URLEncodable {}
extension Int32: URLEncodable {}
extension Int64: URLEncodable {}
extension UInt8: URLEncodable {}
extension UInt16: URLEncodable {}
extension UInt32: URLEncodable {}
extension UInt64: URLEncodable {}

extension TimeInterval: URLEncodable {
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        switch encoder.timeIntervalPrecision {
            case .seconds: return String(self)
            case .milliseconds: return String(self * 1000)
        }
    }
}

extension DateInterval: URLEncodable {
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        guard start != end, duration > 0 else {             // If we know that the start and end dates are exactly the same,
            return start.urlEncodedString(using: encoder)   // then just return the start date now and be done.
        }
        
        let fromDate = start.urlEncodedString(using: encoder)
        let toDate = end.urlEncodedString(using: encoder)
        
        guard fromDate != toDate else { // If the decoded strings end up looking the same (e.g. same year),
            return fromDate             // then just return the first value.
        }
        
        return fromDate + encoder.rangeSeparator + toDate
    }
}

extension Array: URLEncodable/* where Element: URLEncodable */{ // FIXME: Uncomment when conditional conformance is available.
    internal func urlEncodedString(using encoder: URLEncoder) -> String {

        guard Element.self is URLEncodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to `URLEncodable` because \(Element.self) does not conform to `URLEncodable`")
        }
        
        return self.flatMap { ($0 as! URLEncodable).urlEncodedString(using: encoder) }.joined(separator: encoder.listSeparator)
    }
}

extension ClosedRange: URLEncodable/* where Bound: URLEncodable */{ // FIXME: Uncomment when conditional conformance is available.
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        
        guard Bound.self is URLEncodable.Type else {
            preconditionFailure("\(type(of: self)) does not conform to `URLEncodable` because \(Bound.self) does not conform to `URLEncodable`")
        }
        
        let start = (lowerBound as! URLEncodable).urlEncodedString(using: encoder)
        let end = (upperBound as! URLEncodable).urlEncodedString(using: encoder)
        
        guard start != end else {   // If the decoded strings end up looking the same (e.g. rounded-up values),
            return start            // then just return the first value.
        }
        
        return start + encoder.rangeSeparator + end
    }
}

extension RawRepresentable where RawValue: URLEncodable, Self: URLEncodable { // Must apply `URLEncodable` to every RawRepresentable type until conditional conformance is available.
    internal func urlEncodedString(using encoder: URLEncoder) -> String {
        return self.rawValue.urlEncodedString(using: encoder)
    }
}
