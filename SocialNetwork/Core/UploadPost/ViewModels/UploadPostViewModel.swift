//
//  UploadPostViewModel.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 25/12/22.
//

import Foundation

class UploadPostViewModel: ObservableObject {
    @Published var didUploadTweeet = false
    let service = PostService()
    
    func uploadPost(withCaption caption: String) {
        service.uploadPost(caption: caption) { success in
            if success {
                //dismiss view
                self.didUploadTweeet = true
            } else {
                //show error
            }
        }
    }
}
