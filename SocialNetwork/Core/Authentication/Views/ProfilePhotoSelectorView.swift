//
//  ProfilePhotoSelectorView.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 23/12/22.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Setup account", title2: "Add a profile photo")
            
            Button {
                print("Pick image here..")
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                } else {
                    Image("addProfile")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.themeColor)
                        
                }
            }.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .modifier(ProfileImageModifier())
            
            if let selectedImage = selectedImage {
                Button {
                    print("DEBUD: Finish registering user..")
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color.themeColor)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 0)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 180, height: 180)
            .overlay(
                RoundedRectangle(cornerRadius: 90)
                    .stroke(Color.themeColor, lineWidth: 10)
            )
            .clipShape(Circle())
            .padding(.top, 44)
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
