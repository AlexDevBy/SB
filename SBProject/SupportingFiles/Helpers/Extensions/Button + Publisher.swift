//
//  Button + Publisher.swift
//  TaskEffectiveMobile
//
//  Created by Евгений Юнкин on 14.12.22.
//


import UIKit
import Combine

extension UIButton {

    var tapPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }

}
