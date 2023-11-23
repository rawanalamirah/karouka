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
    
    enum AuthError: Error {
        case userNotFound
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
    
    func createUser(withEmail email: String, password: String, fullname: String, infant: String, cribID: String, profilepic: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            let user = user(id: result.user.uid, profilepic: profilepic, fullname: fullname, infant: infant, cribID: cribID, email: email, password: password)
            
            
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
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(AuthError.userNotFound))
            return
        }

        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.userSession = nil 
                self.currentUser = nil
                completion(.success(()))
            }
        }
    }
    
    func updateFullname(fullname: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        do {
            try await Firestore.firestore().collection("users").document(currentUser.uid).setData(["fullname": fullname], merge: true)
            await fetchUser() // Assuming fetchUser() is an asynchronous function
        } catch {
            throw error
        }
    }

    func updateInfant(infant: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        do {
            try await Firestore.firestore().collection("users").document(currentUser.uid).setData(["infant": infant], merge: true)
            await fetchUser() // Assuming fetchUser() is an asynchronous function
        } catch {
            throw error
        }
    }
    
    func updateCribID(cribID: String) async throws {
            guard let user = Auth.auth().currentUser else {
                throw AuthError.userNotFound
            }

            // Perform the update in Firestore using the cribID parameter
            let documentReference = Firestore.firestore().collection("users").document(user.uid)
            try await documentReference.updateData(["cribID": cribID])
            
            // Update the local currentUser property
            try await fetchUser()
        }

    func updateEmail(newEmail: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        do {
            try await currentUser.updateEmail(to: newEmail)
            try await Firestore.firestore().collection("users").document(currentUser.uid).setData(["email": newEmail], merge: true)
            await fetchUser() // Assuming fetchUser() is an asynchronous function
        } catch {
            throw error
        }
    }

    func updatePassword(newPassword: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }

        do {
            try await currentUser.updatePassword(to: newPassword)
            await fetchUser() // Assuming fetchUser() is an asynchronous function
        } catch {
            throw error
        }
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
