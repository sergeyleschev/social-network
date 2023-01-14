//
//  FeedViewModel.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 25/12/22.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPosts { posts in
            self.posts = posts
            
            for index in 0 ..< posts.count {
                let uid = posts[index].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.posts[index].user = user
                }
            }
        }
    }
}
