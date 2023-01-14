//
//  PostRowViewModel.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 25/12/22.
//

import Foundation

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    private let service = PostService()
    
    
    init(post: Post) {
        self.post = post
        self.checkIfUserLikedPost()
    }
    
    func likePost() {
        service.likePost(post) {
            self.post.didLike = true
        }
    }
    
    func unlikePost() {
        service.unlikePost(post) {
            self.post.didLike = false
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIsUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
}
