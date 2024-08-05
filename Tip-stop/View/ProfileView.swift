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
    
    @StateObject private var viewModel = ProfileViewModel(favoris: [], utilisateur: Utilisateur(nom: " ", photo: " ", favoris: []))
    
    @StateObject private var viewModelDecouverte = DecouverteViewModel(categories: [
//        Categorie(titre: "", description: "", icon: "", astuces: [], topics: [])
        Categorie(
            titre: "Toutes",
            description: "",
            icon: "",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Productivité",
            description: "Maximiser votre efficacité au quotidien",
            icon: "Productivité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Personnalisation",
            description: "Personnaliser votre iPhone pour une expérience utilisateur unique. Comme vous",
            icon: "Personnalisation",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Utilisation Avancée",
            description: "Explorez les fonctionnalités avancées de votre iPhone, vous n'en reviendrez pas",
            icon: "UtilisationAvancée",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Sécurité & Confidentialité",
            description: "Assurez la sécurité et la confidentialité de vos données grâce à des outils et des paramètres robustes",
            icon: "SécuritéConfidentialité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Connectivité et Communication",
            description: "Optimisez vos communications avec des astuces pour FaceTime, Messages, AirDrop et réseaux sociaux",
            icon: "ConnectivitéCommunication",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Multimédia",
            description: "Maîtrisez l’utilisation des app Photos, Musique, Podcasts et Livres pour une expérience multimédia sans pareil",
            icon: "Multimédia",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Accessibilité",
            description: "Rendez votre iPhone hyper accessible avec des fonctionnalités comme VoiceOver, AssistiveTouch et autres réglages",
            icon: "Accessibilité",
            astuces: [],
            topics: []
        ),
        Categorie(
            titre: "Batterie et Performances",
            description: "Prolongez votre batterie et maintenez les performances optimales de votre iPhone",
            icon: "BatteriePerformances",
            astuces: [],
            topics: []
        )
    ], topics: [])
    
    @State private var selectedCategory = "Toutes"
    
    //@AppStorage
    
    @State private var showImagePicker = false
    //@AppStorage
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

  

    @State private var isModify = false
    @State private var isCancel = false
    @State private var isValidate = false
    
    @State private var failedEnterName = false
    @State private var showingAlert = false
    
    @State private var categories: [Categorie] = [
            Categorie(
                titre: "Toutes",
                description: "",
                icon: "",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Productivité",
                description: "Maximiser votre efficacité au quotidien",
                icon: "Productivité",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Personnalisation",
                description: "Personnaliser votre iPhone pour une expérience utilisateur unique. Comme vous",
                icon: "Personnalisation",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Utilisation Avancée",
                description: "Explorez les fonctionnalités avancées de votre iPhone, vous n'en reviendrez pas",
                icon: "UtilisationAvancée",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Sécurité & Confidentialité",
                description: "Assurez la sécurité et la confidentialité de vos données grâce à des outils et des paramètres robustes",
                icon: "SécuritéConfidentialité",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Connectivité et Communication",
                description: "Optimisez vos communications avec des astuces pour FaceTime, Messages, AirDrop et réseaux sociaux",
                icon: "ConnectivitéCommunication",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Multimédia",
                description: "Maîtrisez l’utilisation des app Photos, Musique, Podcasts et Livres pour une expérience multimédia sans pareil",
                icon: "Multimédia",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Accessibilité",
                description: "Rendez votre iPhone hyper accessible avec des fonctionnalités comme VoiceOver, AssistiveTouch et autres réglages",
                icon: "Accessibilité",
                astuces: [],
                topics: []
            ),
            Categorie(
                titre: "Batterie et Performances",
                description: "Prolongez votre batterie et maintenez les performances optimales de votre iPhone",
                icon: "BatteriePerformances",
                astuces: [],
                topics: []
            )
        ]
    
    let video = [
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=7qHGDyFkoH0",
        "https://www.youtube.com/watch?v=U_iuF4Hdjag",
        "https://www.youtube.com/watch?v=lrdh_eydNGo",
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=7qHGDyFkoH0",
        "https://www.youtube.com/watch?v=U_iuF4Hdjag",
        "https://www.youtube.com/watch?v=lrdh_eydNGo",
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=7qHGDyFkoH0",
        "https://www.youtube.com/watch?v=U_iuF4Hdjag",
        "https://www.youtube.com/watch?v=lrdh_eydNGo",
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=kpodxkjLN0o",
        "https://www.youtube.com/watch?v=7qHGDyFkoH0",
        "https://www.youtube.com/watch?v=U_iuF4Hdjag",
        "https://www.youtube.com/watch?v=lrdh_eydNGo"]
    
    let columns = [
         GridItem(.adaptive(minimum: 100))
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
                    VStack{
                        if let uiImage = image {
                            //viewModel.addUtilisateur()
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 5)
                        }else {
                            ZStack{
                                Circle()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(Color(red: 229, green: 229, blue: 234, opacity: 1.0))
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                    .shadow(radius: 5)
                                    .onTapGesture {
                                        showImagePicker = true
                                    }
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.blue)
                            }
                        }
                    }.sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, Image: self.$image)
                    }
                    Spacer()
                    Spacer()
                    Section{
                        VStack {
                            if isModify {
                                TextField("Entrer votre nom", text: $viewModel.utilisateur.nom)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 180, height: 30)
                                    .textContentType(.username)
                                    .onSubmit {
                                        isValidate.toggle()
                                        viewModel.addUtilisateur()
                                        isModify = false
                                    }
                                HStack {
                                    Spacer()
//                                    Button("Annuler", role: .cancel) {
//                                        if (self.viewModel.utilisateur.nom != self.viewModel.utilisateur.nom){
//                                           
//                                        }else {
//                                           
//                                        }
//                                            isCancel = true
//                                            isModify = false
//                                    }
//                                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
//                                    .scaleEffect(isModify ? 1.2 : 1)
//                                    .animation(.easeOut(duration: 0.2), value: isModify)
                                    
                                    Button("Valider") {
                                        self.failedEnterName = false
                                        if (self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3){
                                            showingAlert.toggle()
                                            self.failedEnterName.toggle()
                                        }else {
                                            isValidate.toggle()
                                            viewModel.addUtilisateur()
                                            isModify = false
                                        }
                                    }
                                    .alert(isPresented: $showingAlert) {
                                        if self.failedEnterName {
                                            return Alert(title: Text("Le nom doit contenir au moins trois lettres"), message: Text("Veuillez modifier"), dismissButton: .default(Text("OK")))
                                        }else {
                                            return Alert(title: Text("Validé"), message: Text("Changé"), dismissButton: .default(Text("OK")))
                                        }
                                    }
                                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                    .scaleEffect(isModify ? 1.2 : 1)
                                    .animation(.easeOut(duration: 0.2), value: isModify)
                                }
                            } else {
                                
                                if viewModel.utilisateur.nom.isEmpty{
                                    Text("Veuillez entrer voter nom")
                                        .foregroundColor(Color.gray)
                                        
                                }else {
                                    Text(viewModel.utilisateur.nom)
                                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                        .overlay(
                                               Rectangle()
                                                   .stroke(.gray, lineWidth: 1)
                                           )
                                        .shadow(radius: 10)
                                HStack {
                                    Spacer()
                                    Button("Modifier") {
                                        isModify = true
                                    }
                                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal, 5)
//                                    .scaleEffect(isModify ? 1.2 : 1)
//                                    .animation(.easeOut(duration: 0.2), value: isModify)
                                }
                                
                                }
                                
         
                            }
                        }
                    }
                }
                .padding()
            }
            Section{
                HStack {
                    Text("Favoris")
                        .font(.title2)
                    .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
                HStack {
                    Text("Catégories:")
                    Picker("Choisir une catégorie", selection: $selectedCategory) {
                        ForEach(viewModelDecouverte.categories) {category in
                            Text(category.titre)
                                .tag(category.titre)
                        }
                    }
                    .pickerStyle(.menu)
                    Spacer()
                }
                .padding(.horizontal)
                .font(.headline)
            }
            
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(video, id: \.self) { item in
                                VideoPlayer(player: AVPlayer(url:  URL(string: item)!))
                                    .frame(height: 160)
                            }
                        }
                        .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
