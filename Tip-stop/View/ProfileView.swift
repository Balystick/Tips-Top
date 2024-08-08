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
// Aurélien - Ajout navigationPath & globalDataModel
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel

        
    //viewModel Profile View Model
    @StateObject private var viewModel = ProfileViewModel(favoris: [], utilisateur: Utilisateur(nom: " ", photo: UIImage(named: ""), favoris: []))
    //viewModel Decouverte View Model
    @StateObject private var viewModelDecouverte = ProfileViewModel2(categories: [
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
    ])
   
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
    @State private var showAlert = false
    //Clear button x in textfield
    
// Aurélien - Déplacement init
//    init() {
//      UITextField.appearance().clearButtonMode = .whileEditing
//    }
    
    //VAR pour valeur nom dans bouton annuler
    @State private var oldName: String = ""
    @State private var newName: String = ""
  
    //Lire valeur user defaults nom
    @State var name : String = UserDefaults.standard.string(forKey: "name") ?? ""

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
    
// Aurélien - Déplacement et complétion init
    init(path: Binding<NavigationPath>, globalDataModel: GlobalDataModel) {
        self._path = path
        self.globalDataModel = globalDataModel
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                
                HStack {
                    Image(systemName: "arrow.left")
                        .onAppear {
                            url.loadImage(&image)
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
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 5)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        }else {
                            ZStack{
                                Circle()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(Color(.customLightGray))
                                    .overlay(Circle().stroke(Color(.customMediumGray), lineWidth: 0.1))
                                    .shadow(radius: 2)
                                    .onTapGesture {
                                        showImagePicker = true
                                    }
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color(.customMediumGray))
                            }
                        }
                    }.sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, Image: self.$image)
                    }
                    .onTapGesture {
                        url.saveImage(image)
                    }
                    Spacer()
                    Spacer()
                    HStack{
                        VStack {
                            // Textfield pour modifier nom profil
                            if isModify {
                                TextField("Entrer votre nom", text: $viewModel.utilisateur.nom)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                    .textContentType(.username)
                                    .onSubmit {
                                        isValidate.toggle()
                                        viewModel.addUtilisateur()
                                        saveName()
                                        isModify = false
                                    }
                                HStack {
                                    Spacer()
                                    //Bouton annuler et retour au text
                                    Button(action: {
                                        oldName =  viewModel.utilisateur.nom
                                        isCancel = true
                                        isModify = false
                                    }, label: {
                                        Text("Annuler")
                                            .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                            .animation(.easeOut(duration: 0.2), value: isModify)
                                            .foregroundColor(.gray)
                                    })
                                    
                                    //Bouton valider et enregistrer nom dans view model et userdefaults
                                    Button(action: {
                                        //Ajout contraintes texte avec alerte si pas respectées
                                        self.saveName()
                                        self.failedEnterName = false
                                        if (self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3){
                                            showingAlert.toggle()
                                            self.failedEnterName.toggle()
                                        }else {
                                            //Fonction pour garder le nom dans le model utilisateur
                                            viewModel.addUtilisateur()
                                            //Fonction pour garder le nom dans les Userdefaults
                                            newName = viewModel.utilisateur.nom
                                            saveName()
                                            oldName = viewModel.utilisateur.nom
                                            isValidate.toggle()
                                            isModify = false
                                        
                                            if oldName != newName{
                                                showAlert.toggle()
                                                isValidate.toggle()
                                                isModify = false
                                            }
                                        }
                                    }, label: {
                                        Text("Valider")
                                            .font(.footnote)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color(.customBlue))
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
                                .padding(.horizontal, 15)
                            } else {
                                if viewModel.utilisateur.nom.isEmpty{
                                    Text("Veuillez entrer voter nom")
                                        .foregroundColor(Color.gray)
                                        .font(.caption)
                                }else {
                                //Nom profil affiché
                                    Text(name)
                                        .multilineTextAlignment(.leading)
                                        .onAppear() {
                                            let data = newName
                                            UserDefaults.standard.set(data, forKey: "name")
                                        }
                                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                        .overlay(
                                               RoundedRectangle(cornerRadius: 5)
                                                .stroke(.gray, lineWidth: 0.2)
                                                .shadow(radius: 20)
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
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 5)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
            
            Section{
                HStack {
                    HStack{
                        Text("Favoris")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(.customYellow))
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
                HStack {
                    Text("Catégories:")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.customMediumGray))
                    //Picker pour filter les videos par catégories
                    Picker("Choisir une catégorie", selection: $selectedCategory){
                        ForEach(viewModelDecouverte.categories) {category in
                            Text(category.titre)
                                .tag(category.titre)
                                .font(.footnote)
                        }
                    }
                    .font(.footnote)
                    .pickerStyle(.menu)
                    .colorScheme(.dark)
                    .foregroundColor(Color(.customMediumGray))
                    .accentColor(Color(.customMediumGray))
      
                    Spacer()
                    
                }
                .padding(.horizontal)
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
                }
            }
        }
        .padding()
// Aurélien - Modification Back Button
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color(white: 0.2))
                }
            }
        }
    }
    
    //Fonction pour garder le nom dans les Userdefaults
    /// Enregistre le nom fourni dans les User Defaults et met à jour la propriété `name`.
    ///
    /// Cette méthode stocke la valeur de `newName` dans les User Defaults sous la clé `"name"`
    /// et met à jour la propriété `name` avec la nouvelle valeur.
    ///
    /// - Note: Assurez-vous que `newName` est défini avant d'appeler cette méthode.
    ///
    /// - Important: Cette méthode ne vérifie pas si le nom est vide ou nul avant de le sauvegarder.
    func saveName() {
        let data = newName
        UserDefaults.standard.set(data, forKey: "name")
        name = newName
    }
}

// Aurélien - Modif preview
#Preview {
    ProfileView(path: .constant(NavigationPath()), globalDataModel: GlobalDataModel())
}
