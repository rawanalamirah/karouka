//
//  File.swift
//  Karouka
//
//  Created by rawan alamirah on 18/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: user?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
            Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
                guard let self = self else { return }
                self.userSession = user
                Task {
                    await self.fetchUser()
                }
            }
            $userSession
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    Task {
                        await self.fetchUser()
                    }
                }
                .store(in: &cancellables)
        }

    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
                        
            DispatchQueue.main.async {
                self.userSession = result.user
            }
            
            await fetchUser()
            
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            let user = user(id: result.user.uid, fullname: fullname, email: email, password: password)
            
            
            DispatchQueue.main.async {
                self.userSession = result.user
            
            }

            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    func signOut() {
        do{
            try Auth.auth().signOut() // signs out backend
            self.userSession = nil // goes back to login screen, user session is empty
            self.currentUser = nil // prevents errors
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            // Handle the case where the user is not found
            return
        }

        try await user.delete()
        self.userSession = nil // goes back to login screen, user session is empty
        self.currentUser = nil // prevents errors
    }
    
    func fetchUser() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }

            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            DispatchQueue.main.async {
                self.currentUser = try? snapshot.data(as: user.self)
            }
        } catch {
            print("DEBUG: Error fetching user: \(error.localizedDescription)")
            print("DEBUG: Current User is \(String(describing: self.currentUser))")
        }
    }


    
}
