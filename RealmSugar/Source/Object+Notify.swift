//
//  Object+Notify.swift
//  RealmSugar
//
//  Created by Niels Koole on 20/04/2017.
//  Copyright © 2017 Niels Koole. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Implement extension

extension Object: NotifyRealmObject { }


// MARK: - Protocol definition + implementation

public protocol NotifyRealmObject: class { }

extension NotifyRealmObject where Self: Object {
    
    public func fireAndNotify(for properties: [String]? = nil, handler: @escaping ((Self) -> Void)) -> NotificationToken {
        
        // Fire right away
        handler(self)
        
        // Return notification block
        return notify(for: properties, handler: handler)
    }
    
    public func notify(for properties: [String]? = nil, handler: @escaping ((Self) -> Void)) -> NotificationToken {
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
