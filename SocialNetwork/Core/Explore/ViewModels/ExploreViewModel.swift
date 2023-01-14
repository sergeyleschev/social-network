//
//  ExploreViewModel.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 24/12/22.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
                
                return users.filter({
                    $0.username.contains(lowercasedQuery) || $0.fullname.lowercased().contains(lowercasedQuery)
                })
        }
         
    }
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
            print("DEBUG: Users \(users)")
        }
    }
}
