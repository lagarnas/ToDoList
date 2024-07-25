//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

class RegisterViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
    }
    
    func register() {
        guard validate() else { return }
        
        firebaseManager?.createUser(with: email, password: password, name: name)
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        
        guard email.contains("@") && email.contains(".") else { return false }
        
        guard password.count >= 6 else { return false }
        
        return true
    }
}
