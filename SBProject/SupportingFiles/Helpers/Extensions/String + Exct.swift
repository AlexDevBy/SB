//
//  String + Exct.swift
//  TaskEffectiveMobile
//
//  Created by Евгений Юнкин on 14.12.22.
//

import UIKit


extension String {
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
