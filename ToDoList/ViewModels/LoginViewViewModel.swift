//
//  LoginViewViewModel.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import Foundation

class LoginViewViewModel: ObservableObject {
    
    @Injected var firebaseManager: FirebaseManager?
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    init() {
        firebaseManager = Configurator.shared.serviceLocator.getService(type: FirebaseManager.self)
    }
    
    func login() {
        guard validate() else { return }
        firebaseManager?.signIn(with: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else  {
            errorMessage = "Please enter valid email."
            return false
        }
        return true
    }
}
