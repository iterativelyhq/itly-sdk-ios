//
//  ItlyCore.swift
//  Iteratively_example
//
//  Created by Konstantin Dorogan on 24.08.2020.
//  Copyright © 2020 Konstantin Dorogan. All rights reserved.
//

import Foundation

@objc public class Itly: NSObject {
    private var config: Options!
    private var context: Event!

    public func alias(_ userId: String, previousId: String?) {
        guard !config.disabled else { return }
        
        self.config.plugins.alias(userId, previousId: previousId)
    }
    
    public func identify(_ userId: String?, properties: Properties?) {
        guard !config.disabled else { return }

        let event = Event(name: "identify", properties: properties?.properties)
        let validation = validate(event)
        
        config.plugins.identify(userId, properties: event, validationResults: validation,  trackInvalid: config.validation.trackInvalid)
        
        validation.filter{ !$0.valid }.forEach{ invalidResult in
            config.logger?.error("Itly Error in tracker.identify(): \(invalidResult.message ?? "")")
        }
    }
    
    public func group(_ userId: String?, groupId: String, properties: Properties?) {
        guard !config.disabled else { return }

        let event = Event(name: "group", properties: properties?.properties)
        let validation = validate(event)
        
        config.plugins.group(userId, groupId: groupId, properties: event, validationResults: validation, trackInvalid: config.validation.trackInvalid)

        validation.filter{ !$0.valid }.forEach{ invalidResult in
            config.logger?.error("Itly Error in tracker.group(): \(invalidResult.message ?? "")")
        }
    }
    
    public func track(_ userId: String?, event: Event) {
        guard !config.disabled else { return }

        let validation = validateContextWithEvent(event)
        
        let combinedEvent = event.mergeProperties(context)
        config.plugins.track(userId, event: combinedEvent, validationResults: validation, trackInvalid: config.validation.trackInvalid)

        validation.filter{ !$0.valid }.forEach{ invalidResult in
            config.logger?.error("Itly Error in tracker.track(\(event.name)): \(invalidResult.message ?? "")")
        }
    }
    
    public func reset() {
        guard !config.disabled else { return }

        config.plugins.reset()
    }
    
    public func flush() {
        guard !config.disabled else { return }

        config.plugins.flush()
    }
    
    public func shutdown() {
        guard !config.disabled else { return }

        config.plugins.shutdown()
    }

    public func load(_ options: Options) {
        guard !options.disabled else {
            options.logger?.info("Itly disabled = true")
            return
        }
        
        self.config = options
        self.context = Event(name: "context", properties: options.context?.properties)
        
        self.config.logger?.debug("Itly load")
        self.config.logger?.debug("Itly \(config.plugins.count) plugins are enabled")

        self.config.plugins.load(options)
    }
    
    private func validate(_ event: Event) -> [ValidationResponse] {
        guard !config.validation.disabled else {
            return []
        }
        
        return config.plugins.validate(event)
    }
    
    private func validateContextWithEvent(_ event: Event) -> [ValidationResponse] {
        let validatedContext = validate(context)
        let validatedEvent = validate(event)
        
        return validatedContext + validatedEvent
    }
}