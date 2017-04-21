//
//  RealmCollection+Notify.swift
//  RealmSugar
//
//  Created by Niels Koole on 22/04/2017.
//  Copyright © 2017 Niels Koole. All rights reserved.
//

import Foundation
import RealmSwift

enum NotifyCollectionType {
    case all
    case inserted
    case modified
    case deleted
    case insertedDeleted
    case insertedModified
    case modifiedDeleted
}

extension AnyRealmCollection {
    
    func fireAndNotify(type: NotifyCollectionType = .all, handler: @escaping ((AnyRealmCollection) -> Void)) -> NotificationToken {
        return _notify(fire: true, type: type, handler: handler)
    }
    
    func notify(type: NotifyCollectionType = .all, handler: @escaping ((AnyRealmCollection) -> Void)) -> NotificationToken {
        return _notify(fire: false, type: type, handler: handler)
    }
    
    private func _notify(fire: Bool, type: NotifyCollectionType, handler: @escaping ((AnyRealmCollection) -> Void)) -> NotificationToken {
        return addNotificationBlock({ [weak self] (change) in
            guard let s = self else { return }
            
            switch change {
            case .initial:
                if fire { handler(s) }
                break
            case .update(_, let deletions, let insertions, let modifications):
                
                if type == .all ||
                    (type == .inserted && insertions.isEmpty == false) ||
                    (type == .modified && modifications.isEmpty == false) ||
                    (type == .deleted && deletions.isEmpty == false) ||
                    (type == .insertedModified && insertions.isEmpty == false && modifications.isEmpty == false) ||
                    (type == .insertedDeleted && insertions.isEmpty == false && deletions.isEmpty == false) ||
                    (type == .modifiedDeleted && deletions.isEmpty == false && modifications.isEmpty == false) {
                    handler(s)
                }
                
                break
            default: break
            }
        })
    }
}
