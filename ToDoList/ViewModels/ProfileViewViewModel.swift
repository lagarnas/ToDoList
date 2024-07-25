//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

class ProfileViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var user: User? = nil
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
    }
    
    func fetchUser() {
        firebaseManager?.fetchUser { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }
    
    func logOut() {
        firebaseManager?.signOut()
    }
    
}
