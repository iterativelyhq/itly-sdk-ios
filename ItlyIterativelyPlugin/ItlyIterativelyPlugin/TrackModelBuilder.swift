//
//  TrackModelBuilder.swift
//  ItlyIterativelyPlugin
//
//  Created by Konstantin Dorogan on 18.09.2020.
//

import Foundation
import ItlyCore

protocol TrackModelBuilder {
    func buildTrackModelForType(_ type: TrackType, event: Event?, properties: Properties?, validation: ValidationResponse?) -> TrackModel
}

extension TrackModelBuilder {
    func buildTrackModelForType(_ type: TrackType, event: Event? = nil, properties: Properties? = nil, validation: ValidationResponse? = nil) -> TrackModel{
        return self.buildTrackModelForType(type, event: event, properties: properties, validation: validation)
    }

}

class DefaultTrackModelBuilder: TrackModelBuilder {
    private let omitValues: Bool
    
    func buildTrackModelForType(_ type: TrackType, event: Event?, properties: Properties?, validation: ValidationResponse?) -> TrackModel {
        let valid = validation?.valid ?? true
        let details = omitValues ? "" : validation?.message ?? ""
        let sanitizedProperties = omitValues ? properties?.sanitizedProperties : properties?.properties

        return TrackModel(
            type: type,
            eventId: event?.id,
            eventSchemaVersion: event?.version,
            eventName: event?.name,
            properties: sanitizedProperties,
            valid: valid,
            validation: Validation(details: details)
        )
    }
    
    init(omitValues: Bool) {
        self.omitValues = omitValues
    }
}


extension Properties {
    var sanitizedProperties: [String: Any] {
        return self.properties.mapValues{ _ in NSNull() }
    }
}