//
//  NewItemViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

class NewItemViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var title: String = ""
    @Published var dueDate: Date = Date()
    @Published var showAlert: Bool = false
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)}
    
    func save()  {
        guard canSave else { return }
        
        firebaseManager?.saveItem(title: title, dueDate: dueDate)
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        guard dueDate >= Date().addingTimeInterval(-86400) else { return false }
        return true
    }
}
