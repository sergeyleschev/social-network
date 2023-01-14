//
//  FeedView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 21/12/22.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewPostView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        PostRowView(post: post)
                            .padding()
                    }
                }
            } 
            
            Button {
                print("New post")
                showNewPostView.toggle()
            } label: {
                Image("newPost")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
            }
            .background(Color.themeColor)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .padding(.trailing, 10)
            .padding(.bottom, 20)
            .fullScreenCover(isPresented: $showNewPostView, onDismiss: {
                viewModel.fetchPosts()
            }) {
               NewPostView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
       
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
