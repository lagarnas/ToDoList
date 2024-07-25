//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

/// ViewMidel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var showingNewItemView: Bool = false
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
    }
    
    
    /// Delete to do list item
    /// - Parameter id: item id to delete
    func delete(id: String) {
        firebaseManager?.deleteItem(by: id, userId: userId)
    }
}
