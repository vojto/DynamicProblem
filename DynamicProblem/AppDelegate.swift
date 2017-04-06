//
//  AppDelegate.swift
//  DynamicProblem
//
//  Created by Vojtech Rinik on 4/6/17.
//  Copyright © 2017 Vojtech Rinik. All rights reserved.
//

import Cocoa
import ReactiveSwift
import ReactiveCocoa
import enum Result.NoError

class Config: NSObject {
    dynamic var mood: String = "great"
}

public func asString(_ value: Any?) -> String? {
    return value as? String
}

extension Reactive where Base: Config {
    var mood: SignalProducer<String?, NoError> {
        return self.producer(forKeyPath: #keyPath(Config.mood))
            .map(asString)
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let config = Config()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
    
        config.reactive.mood.startWithValues { mood in
            Swift.print("Mood changed to \(mood)!")
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }


}

