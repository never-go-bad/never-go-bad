//
//  StringExtensions.swift
//  APItests
//
//  Created by Andre Oriani on 3/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import Foundation


import Foundation

extension String {
    func contains(aString: String) -> Bool {
        return self.lowercaseString.rangeOfString(aString.lowercaseString) != nil
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func truncate(length: Int) -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length))
        } else {
            return self
        }
    }
    
    func urlEncode() -> String {
        return self.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func replace(text: String, by replacement: String) -> String {
        return self.stringByReplacingOccurrencesOfString(text, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func words() -> [String] {
        
        let range = Range<String.Index>(start: self.startIndex, end: self.endIndex)
        var words = [String]()
        
        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByWords) { (substring, _, _, _) -> () in
            words.append(substring!)
        }
        return words
    }
    
}