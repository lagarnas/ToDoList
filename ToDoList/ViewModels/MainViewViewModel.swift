//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

class MainViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var currentUserId: String = ""
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
        firebaseManager?.addStateDidChangeListener { [weak self] userId in
            DispatchQueue.main.async {
                self?.currentUserId = userId
            }
        }
    }
    
    public var isSingIn: Bool {
        return firebaseManager?.isSingIn ?? false
    }
}


