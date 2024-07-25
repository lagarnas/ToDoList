//
//  FirebaseManager.swift
//  ToDoList
//
//  Created by Анастасия Леонтьева on 24.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class FirebaseManager {
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    static func configure() {
        FirebaseApp.configure()
    }
    
    func addStateDidChangeListener(completion: @escaping (String) -> Void) {
        self.handler = Auth.auth().addStateDidChangeListener { _, user in
            completion(user?.uid ?? "")
        }
    }
    
    func fetchUser(completion: @escaping (User) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else { return }
            let user = User(id: data["id"] as? String ?? "",
                            name: data["name"] as? String ?? "",
                            email: data["email"] as? String ?? "",
                            joined: data["jouned"] as? TimeInterval ?? 0
            )
            completion(user)
        }
    }
    
    func createUser(with email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else { return }
            self?.insertUserRecord(id: userId, name: name, email: email)
        }
    }
    
    func saveItem(title: String, dueDate: Date) {
        guard let uId = Auth.auth().currentUser?.uid else { return  }
        // create a model
        let newId = UUID().uuidString
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false)
        
        // save model
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    func deleteItem(by id: String, userId: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func toggleItemIsDone(item: ToDoListItem) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(item.id)
            .setData(item.asDictionary())
        
    }
    
    func signIn(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    var isSingIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    // Private
    
    private func insertUserRecord(id: String, name: String, email: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
}
