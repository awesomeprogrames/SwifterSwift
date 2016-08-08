//
//  StringExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
public extension String {
    
    // tested
    public var locale: Locale {
        return Locale.current
    }
    
    // tested
    public func count(of string: String) -> Int {
        return components(separatedBy: string).count - 1
    }
    
    // tested
    public func starts(with prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    // tested
    public func ends(with suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    // tested
    public var empty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0
    }
    
    // tested
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    // tested
    public var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // tested
    public mutating func trim() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // tested
    public var firstCharacter: String? {
        return Array(self.characters).map({String($0)}).first
    }
    
    // tested
    public var lastCharacter: String? {
        return Array(self.characters).map({String($0)}).last
    }
    
    // tested
    public var withoutSpacesAndNewLines: String {
        return self.replace(string: " ", with: "").replace(string: "\n", with: "")
    }
    
    // tested
    public var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(self.withoutSpacesAndNewLines.characters.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    // tested
    public var camelCaseString: String {
        let source = self.lowercased()
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(after: source.startIndex))
            let camel = source.capitalized.replace(string: " ", with: "").replace(string: "\n", with: "")
            let rest = String(camel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(after: source.startIndex))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
            
        }
    }
    
    // tested
    public mutating func camelize() {
        self = self.camelCaseString
    }
    
    public func lines() -> [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Return true is string is http URL
    public var isHttpUrl: Bool {
        guard self.starts(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return true is string is https URL
    public var isHttpsUrl: Bool {
        guard self.starts(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }
    
    /// Return reversed string
    public var reversed: String {
        return String(characters.reversed())
    }
    
    public mutating func reverse() {
        self = String(characters.reversed())
    }
    
    /// Return the first index of a substring in a string
    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    /// Replace part of string with another string
    public func replace(string: String, with: String) -> String {
        return self.replacingOccurrences(of: string, with: with)
    }
    
    /// Return true is string contain one or more decimal number
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    /// Return true is string contain one or more letter
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    /// Return true is string contain one or more letters and one or more number, usually used to validate passwords
    public var isAlphaNumeric: Bool {
        return self.components(separatedBy: CharacterSet.alphanumerics).joined(separator: "").characters.count == 0
    }
    
    /// Return true is string contain letters only
    public var isAlphabetic: Bool {
        return  hasLetters && !hasNumbers
    }
    
    /// Return true is string contain decimal numbers only
    public var isNumeric: Bool {
        return  !hasLetters && hasNumbers
    }
    
    /// Return latinized string, changes non latin letters with latin letters. eg: è becomes e
    public var latinized: String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    /// Latinize a string, changes non latin letters with latin letters. eg: è becomes e
    public mutating func latinize() {
        self = self.latinized
    }
    
    /// Return a random string of given length
    public static func random(of length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var string = ""
        for _ in 0..<length {
            let randomIndex = arc4random_uniform(UInt32(base.characters.count))
            string += "\(base[base.index(base.startIndex, offsetBy: IndexDistance(randomIndex))])"
        }
        return string
    }
    
    /// Return Int value from string (if possible)
    public var toInt: Int? {
        return Int(self)
    }
    
    /// Return Int8 value from string (if possible)
    public var toInt8: Int8? {
        return Int8(self)
    }
    
    /// Return Int16 value from string (if possible)
    public var toInt16: Int16? {
        return Int16(self)
    }
    
    /// Return Int32 value from string (if possible)
    public var toInt32: Int32? {
        return Int32(self)
    }
    
    /// Return Int64 value from string (if possible)
    public var toInt64: Int64? {
        return Int64(self)
    }
    
    /// Return Float value from string (if possible)
    public var toFloat: Float? {
        return Float(self)
    }
    
    /// Return Float32 value from string (if possible)
    public var toFloat32: Float32? {
        return Float32(self)
    }
    
    /// Return Float64 value from string (if possible)
    public var toFloat64: Float64? {
        return Float64(self)
    }
    
    /// Return Float80 value from string (if possible)
    public var toFloat80: Float80? {
        return Float80(self)
    }
    
    /// Return Double value from string (if possible)
    public var toDouble: Double? {
        return Double(self)
    }
    
    /// Return Bool value from string (if possible)
    public var toBool: Bool? {
        if self == "true" || self == "TRUE" || self == "1" {
            return true
        } else if self == "false" || self == "FLASE" || self == "0" {
            return false
        } else {
            return nil
        }
    }
}
