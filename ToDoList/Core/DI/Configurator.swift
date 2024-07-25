//
//  Configurator.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 24.07.2024.
//

import Foundation

class Configurator {
    static let shared = Configurator()
    let serviceLocator = ServiceLocator()
    
    func setup() {
        registerServices()
    }
    
   private func registerServices() {
       // 2. Перевести существующие сервисы на него
        serviceLocator.addService(service: FirebaseManager())
    }
}
