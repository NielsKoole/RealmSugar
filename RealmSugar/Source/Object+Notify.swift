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
    
    func notify(for properties: [String], handler: ((Object) -> Void)?) -> NotificationToken {
        return addNotificationBlock({ [weak self] (change) in
            guard let s = self else { return }
            
            switch change {
            case .change(let changedProperties):
                let mapped = changedProperties.map { $0.name }
                let foundProps = mapped.filter { properties.index(of: $0) != nil }
                
                if foundProps.isEmpty == false {
                    handler?(s)
                }
            default: break
            }
        })
    }
}
