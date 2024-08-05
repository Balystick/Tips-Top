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
    
    //viewModel Profile View Model
    @StateObject private var viewModel = ProfileViewModel(favoris: [], utilisateur: Utilisateur(nom: " ", photo: UIImage(named: ""), favoris: []))
    //viewModel Decouverte View Model
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
   
    // Catégorie sélectionnée automatiquement dans picker
    @State private var selectedCategory = "Toutes"

    // Booleen afficher ImagePicker
    @State private var showImagePicker = false
    //VAR qui stocke image de profil via l'Image Picker
    @State private var image: UIImage?
   //Source de la photo de profil, ici photo library
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    //VAR recuperer lien image profil choisie
    private var url: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("image.jpg")
    }


    //Booleens boutons textfield
    @State private var isModify = false
    @State private var isCancel = false
    @State private var isValidate = false
    //Booleens alert textield
    @State private var failedEnterName = false
    @State private var showingAlert = false
    //Clear button x in textfield
    init() {
      UITextField.appearance().clearButtonMode = .whileEditing
    }
    //VAR pour valeur nom dans bouton annuler
    @State private var oldName: String = ""
    @State private var newName: String = ""
  
    
    //Liste tab catégories
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
    
    //Tab de video pour grid favoris
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
    
    //Grid de list favoris
    let columns = [
         GridItem(.adaptive(minimum: 100))
     ]

    var body: some View {
        VStack {
            VStack(alignment: .leading){
                HStack {
                    Image(systemName: "arrow.left")
                        .onAppear {
                            url.loadImage(&image)
                        }
                        .onTapGesture {
                            url.saveImage(image)
                        }
                    Text("Profil")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .offset(x: 120)
                }
                
                HStack{
                    VStack{
                        // Photo image profile ou vide avec icone
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
                            // Textfield pour modifier nom profil
                            if isModify {
                                TextField("Entrer votre nom", text: $viewModel.utilisateur.nom)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 180, height: 30)
                                    .textContentType(.username)
                                    .onSubmit {
                                        isValidate.toggle()
                                        viewModel.addUtilisateur()
                                        saveName(data: viewModel.utilisateur.nom)
                                        isModify = false
                                    }
                                HStack {
                                    Spacer()
                                    //Bouton annuler et retour au text
                                    Button(action: {
                                        viewModel.utilisateur.nom = oldName

                                        isCancel = true
                                        isModify = false
                                    }, label: {
                                        Text("Annuler")
                                            .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                            .scaleEffect(isModify ? 1.2 : 1)
                                            .animation(.easeOut(duration: 0.2), value: isModify)
                                    })
                                    Spacer()
                                    //Bouton valider et enregistrer nom dans view model et userdefaults
                                    Button(action: {
                                        //Ajout contraintes texte avec alerte si pas respectées
                                        self.saveName(data: viewModel.utilisateur.nom)
                                        self.failedEnterName = false
                                        if (self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3){
                                            showingAlert.toggle()
                                            self.failedEnterName.toggle()
                                        }else {
                                            isValidate.toggle()
                                            //Fonction pour garder le nom dans les model utilisateur
                                            viewModel.addUtilisateur()
                                            //Fonction pour garder le nom dans les Userdefaults
                                            oldName = viewModel.utilisateur.nom
                                            saveName(data: viewModel.utilisateur.nom)
                                            newName = viewModel.utilisateur.nom
                                            isModify = false
                                        }
                                    }, label: {
                                        Text("Valider")
                                            .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                    })
                                    //Affiche alerte si contraintes pas respectées
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
                                        .font(.caption)
                                        
                                }else {
                                
                                
                                //Nom profil affiché
                                    Text(viewModel.utilisateur.nom)
                                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                        .overlay(
                                               Rectangle()
                                                   .stroke(.gray, lineWidth: 1)
                                           )
                                        .shadow(radius: 10)
                                HStack {
                                    Spacer()
                                    //Bouton Modifier pour modifier nom de profil
                                    Button("Modifier") {
                                        isModify = true
                                    }
                                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal, 5)
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
                    //Picker pour filter les videos par catégories
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
                    // Scroll pour afficher liste video en grid
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
    
    //Fonction pour garder le nom dans les Userdefaults
    func saveName(data: String) {
        UserDefaults.standard.set(data, forKey: "name")

        print("saved name string:" + data.description)
//        print(savedName)
        print(viewModel.utilisateur.nom)
//        print(url)
        print("oldName is: \(oldName)")
        print("newName is: \(newName)")
    }
}


#Preview {
    ProfileView()
}
