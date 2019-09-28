
//
//  Name.swift
//
//  Created by Jamal alayq on 9/7/19.
//  Copyright © 2019 Jamal Alayq. All rights reserved.
//

import Foundation

public struct Name: ExpressibleByStringLiteral, CustomStringConvertible {
    
    public var description: String {
        return "Name is: \(value)"
    }
    
    public let value: String
    
    /// Number of words in name
    /// default value: 4
    public var countOfName: UInt = 4
    
    /// Number of letters in name
    /// default value: 20
    public var countOfLetters: UInt = 20
    
    /// Number of repeating letters in a sequence
    /// default value: 2
    public var numberOfRepeatedLettersInASequence: UInt = 2
    
    public init(_ value: String) {
        self.value = value
    }
    
    public init(stringLiteral value: String) {
        self = Name(value)
    }
    
   public var isValid: Bool {
        guard !value.isEmpty else { return false }
        guard value.count > 2 else { return false }
        guard countOfLetters > countOfName, numberOfRepeatedLettersInASequence < countOfLetters else { return false }
        guard matchNumberOfWords() else { return false }
        guard matchCountOfLetters() else { return false }
        guard !containsDigits() else { return false }
        guard notContainsMoreThanRepeatedNumberAllowed() else { return false }
        return true
    }
    
    public func validate() throws {
        guard !value.isEmpty else { throw NameErrors.empty }
        guard value.count > 2 else { throw NameErrors.invalid }
        guard countOfLetters > countOfName, numberOfRepeatedLettersInASequence < countOfLetters else { throw NameErrors.invalidRestrictions }
        guard matchNumberOfWords() else { throw NameErrors.invalidNumberOfWords }
        guard matchCountOfLetters() else { throw NameErrors.invalidNumberOfLetters }
        guard !containsDigits() else { throw NameErrors.containsNumbers }
        guard notContainsMoreThanRepeatedNumberAllowed() else { throw NameErrors.repeatedAlphabetsMoreThanNeeded }
    }
    
    public enum NameErrors: Error {
        case empty
        case invalid
        case invalidRestrictions
        case invalidNumberOfWords
        case invalidNumberOfLetters
        case containsNumbers
        case repeatedAlphabetsMoreThanNeeded
    }
    
}

// MARK:- Private block

private extension Name {
    
    private func notContainsMoreThanRepeatedNumberAllowed() -> Bool {
        let numberOfInvalidCount = Int(self.numberOfRepeatedLettersInASequence + 1)
        var previousChar: Character = value.first!
        var sameLetters = Array<Character>()
        
        for (index, char) in value.enumerated() {
            if index == 0 {
                sameLetters.append(char)
                continue
            }
            
            if char == previousChar {
                sameLetters.append(char)
            }
            
            if sameLetters.count >= numberOfInvalidCount {
                return false
            }
            
            previousChar = char
        }
        return true
    }
    
    private func matchNumberOfWords() -> Bool {
        return value.components(separatedBy: " ").count <= countOfName
    }

    private func matchCountOfLetters() -> Bool {
        return value.count <= countOfLetters
    }
    
    private func containsDigits() -> Bool {
        return value.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
}

// MARK:- Codability

extension Name: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}

// MARK:- Equalability

extension Name: Equatable {
    
    public static func == (lhs: Name, rhs: Name) -> Bool {
        return lhs.value == rhs.value && lhs.isValid && rhs.isValid
    }
    
}

// MARK:- Hashability

extension Name: Hashable {
    
    public func hash(into haser: inout Hasher) {
        haser.combine(value)
    }
    
}
