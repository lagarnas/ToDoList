//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 18.07.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseManager.configure()
        Configurator.shared.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
