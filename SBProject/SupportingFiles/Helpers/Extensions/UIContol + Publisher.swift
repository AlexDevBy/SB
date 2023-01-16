//
//  UIContol + Publisher.swift
//  TaskEffectiveMobile
//
//  Created by Евгений Юнкин on 14.12.22.
//

import UIKit
import Combine

// swiftlint:disable nesting

extension UIControl {

    struct EventPublisher: Publisher {

        typealias Output = Void
        typealias Failure = Never

        fileprivate var control: UIControl
        fileprivate var event: Event

        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Void == S.Input {
            let subscription = EventSubscription(subscriber: subscriber)
            subscriber.receive(subscription: subscription)

            control.addTarget(subscription, action: #selector(subscription.trigger), for: event)
        }
    }

    func publisher(for event: Event) -> EventPublisher {
        EventPublisher(control: self, event: event)
    }

}

private extension UIControl {

    class EventSubscription<S: Subscriber>: Subscription where S.Input == Void {
        var subscriber: S?

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }

        init(subscriber: S) {
            self.subscriber = subscriber
        }

        @objc func trigger() {
            _ = subscriber?.receive()
        }
    }

}

