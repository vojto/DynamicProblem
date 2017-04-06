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
        return self.values(forKeyPath: #keyPath(Config.mood))
            .take(during: lifetime)
            .map(asString)
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let config = Config()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
//        withUnsafePointer(to: config.reactive.lifetime) {
            Swift.print("Config's lifetime: \(Unmanaged.passUnretained(config.reactive.lifetime).toOpaque())")
//        }
        
        
        
    
        config.reactive.mood.startWithValues { mood in
            Swift.print("Mood changed to \(mood)!")
            
            if mood == nil {
                Swift.print("well bummer")
            }
        }
        
        config.reactive.lifetime.ended.observeCompleted {
            Swift.print("CONFIG ZDOCHOL!!")
        }
        
//        config.reactive.mood.logEvents().startWithValues { _ in
//            
//        }

        
        config.mood = "poor"
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        
    }


}

