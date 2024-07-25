//
//  ToDoListItemViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

/// ViewMidel for single to do list item view (each row in items list)
class ToDoListItemViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
    }
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        firebaseManager?.toggleItemIsDone(item: itemCopy)
    }
}
