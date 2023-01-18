//
//  extHyperLink.swift
//  SBProject
//
//  Created by Alex Misko on 17.01.23.
//

import Foundation
import UIKit
extension NSAttributedString {
    
    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributdString = NSMutableAttributedString(string: string)
        attributdString.addAttribute(.link, value: path, range: substringRange)
        return attributdString
    }
}
