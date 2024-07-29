//
//  Profile.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI
import AVKit
import PhotosUI

struct ProfileView: View {
    @State private var nom: String = ""
    @State private var showImagePicker = false
    @State private var imageChoisie : UIImage?

    let video = ["https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=7qHGDyFkoH0", "https://www.youtube.com/watch?v=U_iuF4Hdjag", "https://www.youtube.com/watch?v=lrdh_eydNGo", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=7qHGDyFkoH0", "https://www.youtube.com/watch?v=U_iuF4Hdjag", "https://www.youtube.com/watch?v=lrdh_eydNGo",
        "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=7qHGDyFkoH0", "https://www.youtube.com/watch?v=U_iuF4Hdjag", "https://www.youtube.com/watch?v=lrdh_eydNGo", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=kpodxkjLN0o", "https://www.youtube.com/watch?v=7qHGDyFkoH0", "https://www.youtube.com/watch?v=U_iuF4Hdjag", "https://www.youtube.com/watch?v=lrdh_eydNGo"]
    
  //  let data = (1...100).map { "Item \($0)" }
    let columns = [
         GridItem(.adaptive(minimum: 80))
     ]

    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Profile")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .offset(x: 120)
                }
                HStack{
                            Image("angelo")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 10)
                                .onTapGesture {
                                    showImagePicker = true
                                }


                    VStack(alignment: .leading){
                        TextField("Entrer votre nom", text: $nom)
                            .multilineTextAlignment(.leading)
                        Button("Modifier") {
                        }
                        .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                        .underline()
                        .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                        
                    }
                    .padding()
                }
            }
            
            VStack(alignment: .leading){
                Text("Favoris")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack {
                    Text("Catégories")
                    Text("Toutes")
                }
                .font(.headline)
            }
            
                VStack {
                    ScrollView {
                               LazyVGrid(columns: columns, spacing: 10) {
                                   ForEach(video, id: \.self) { item in
                                       VideoPlayer(player: AVPlayer(url:  URL(string: item)!))
                                           .frame(height: 150)
                                      // Text(item)
//                                             .font(.largeTitle)
//                                             .padding()
//                                             .background(Color.blue)
//                                             .foregroundColor(.white)
//                                             .clipShape(RoundedRectangle(cornerRadius: 20))

                                   }
                               }
                               .padding(.horizontal)
                }
            }
        }
        .padding()
//        .onChange(of: imageChoisie) { _ in loadImage() }
    }
    func loadImage(){
//        guard let image = imageChoisie else {return}
//        imageChoisie = Image(uiImage: image)
    }
}

#Preview {
    ProfileView()
}
