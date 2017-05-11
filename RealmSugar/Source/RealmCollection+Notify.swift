//
//  RealmCollection+Notify.swift
//  RealmSugar
//
//  Created by Niels Koole on 22/04/2017.
//  Copyright © 2017 Niels Koole. All rights reserved.
//

import Foundation
import RealmSwift

public enum NotifyCollectionType {
    case inserted
    case modified
    case deleted
}

// MARK: - Implement extension

extension List: NotifyRealmCollection { }

extension Results: NotifyRealmCollection { }

extension LinkingObjects: NotifyRealmCollection { }


// MARK: - Protocol definition + implementation

public protocol NotifyRealmCollection: class, RealmCollection { }

extension NotifyRealmCollection {
    
    public func fireAndNotify(when types: [NotifyCollectionType]? = nil, handler: @escaping ((Self) -> Void)) -> NotificationToken {
        return _notify(fire: true, types: types, handler: handler)
    }
    
    public func notify(when types: [NotifyCollectionType]? = nil, handler: @escaping ((Self) -> Void)) -> NotificationToken {
        return _notify(fire: false, types: types, handler: handler)
    }
    
    private func _notify(fire: Bool, types: [NotifyCollectionType]?, handler: @escaping ((Self) -> Void)) -> NotificationToken {
        return addNotificationBlock({ [weak self] (change) in
            guard let s = self else { return }
            
            switch change {
            case .initial:
                if fire { handler(s) }
                break
            case .update(_, let deletions, let insertions, let modifications):
                
                // If there are no types specified, we always notify :)
                guard let types = types else { return handler(s) }
                
                // Validate if the correct changes to the collection are followed
                if types.filter({ $0 == .inserted }).isEmpty == false && insertions.isEmpty == false {
                    handler(s)
                } else if types.filter({ $0 == .modified }).isEmpty == false && modifications.isEmpty == false {
                    handler(s)
                } else if types.filter({ $0 == .deleted }).isEmpty == false && deletions.isEmpty == false {
                    handler(s)
                }
                
                break
            default: break
            }
        })
    }
}
