//
//  Object+Notify.swift
//  RealmSugar
//
//  Created by Niels Koole on 20/04/2017.
//  Copyright © 2017 Niels Koole. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    
    public func fireAndNotify(for properties: [String]? = nil, handler: @escaping ((Object) -> Void)) -> NotificationToken {
        
        // Fire right away
        handler(self)
        
        // Return notification block
        return notify(for: properties, handler: handler)
    }
    
    public func notify(for properties: [String]? = nil, handler: @escaping ((Object) -> Void)) -> NotificationToken {
        return addNotificationBlock({ [weak self] (change) in
            guard let s = self else { return }
            
            switch change {
            case .change(let changedProperties):
                if let properties = properties {
                    let mapped = changedProperties.map { $0.name }
                    let foundProps = mapped.filter { properties.index(of: $0) != nil }
                    
                    if foundProps.isEmpty == false {
                        handler(s)
                    }
                } else {
                    handler(s)
                }
            default: break
            }
        })
    }
}
