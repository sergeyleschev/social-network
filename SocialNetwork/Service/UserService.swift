//
//  UserService.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 24/12/22.
//

import Firebase

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                var user: User
                
                do {
                    user = try snapshot.data(as: User.self)
                } catch {
                    print ("Error fetchUser: \(error)")
                    return
                }
                
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) { 
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self)})
                
                completion(users)
            }
    }
}
