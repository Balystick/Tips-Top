//
//  Profile.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024
//  Modified by Aurélien
//

import SwiftUI
import AVKit
import PhotosUI
import AVFoundation

struct ProfileView: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = ProfileViewModel()
    //---------------
    @StateObject private var viewModelScrollView = InfiniteScrollViewModel()
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
    
    //VAR pour valeur nom dans bouton annuler
    @State private var oldName: String = ""
    @State private var newName: String = ""
    
    //Grid de list favoris
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    // gestion de la lecture des vidéos
    @State private var currentPlayingVideo: String? = nil
    @Binding var favoriteVideoSelected: String?
    
    // Vidéos favorites
    @State private var favoritedVideos: [[String: String]] = UserDefaults.standard.array(forKey: "favoritedVideos") as? [[String: String]] ?? []

    var filteredFavoritedVideos: [[String: String]] {
        if selectedCategory == "Toutes" {
            return favoritedVideos
        } else {
            return favoritedVideos.filter { $0["category"] == selectedCategory }
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                
                HStack{
                    VStack{
                        // Photo image profile ou vide avec icone
                        if let uiImage = image {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                .shadow(radius: 5)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        } else {
                            ZStack{
                                Circle()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(Color(.customLightGray))
                                    .overlay(Circle().stroke(Color(.customMediumGray), lineWidth: 0.1))
                                    .shadow(radius: 2)
                                    .onTapGesture {
                                        showImagePicker = true
                                    }
                                
                                AsyncImage(url: URL(string: viewModel.utilisateur.photo)){ image in
                                    image
                                        .image?.resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .offset(y: 40)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            showImagePicker = true
                                        }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, Image: self.$image)
                    }
                    .onChange(of: image) { oldValue, newValue in
                        viewModel.saveImage(newValue)
                    }
                    Spacer()
                    Spacer()
                    HStack{
                        VStack {
                            // Textfield pour modifier nom profil
                            if isModify {
                                TextField("Entrer votre nom", text: $viewModel.utilisateur.nom)
                                    .font(.caption)
                                    .foregroundColor(Color(.customMediumGray))
                                    .textFieldStyle(.roundedBorder)
                                    .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                    .textContentType(.username)
                                    .onSubmit {
                                        isValidate.toggle()
                                        viewModel.addUtilisateur()
                                        viewModel.saveName(viewModel.utilisateur.nom)
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
                                            .animation(.easeOut(duration: 0.2), value: isModify)
                                            .foregroundColor(.gray)
                                    })
                                    
                                    //Bouton valider et enregistrer nom dans view model et userdefaults
                                    Button(action: {
                                        //Ajout contraintes texte avec alerte si pas respectées
                                        //    Aurélien                                    self.saveName()
                                        self.failedEnterName = false
                                        if (self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3){
                                            showingAlert.toggle()
                                            self.failedEnterName.toggle()
                                        } else {
                                            //Fonction pour garder le nom dans le model utilisateur
                                            viewModel.addUtilisateur()
                                            //Fonction pour garder le nom dans les Userdefaults
                                            newName = viewModel.utilisateur.nom
                                            viewModel.saveName(newName)
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
                                    Text("Veuillez entrer votre nom")
                                        .foregroundColor(Color(.customMediumGray))
                                        .font(.caption)
                                } else {
                                    //Nom profil affiché
                                    Text(viewModel.utilisateur.nom)
                                        .multilineTextAlignment(.leading)
                                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.gray, lineWidth: 0.2)
                                                .shadow(radius: 20)
                                        )
                                        .shadow(radius: 10)
                                }
                                HStack {
                                    Spacer()
                                    //Bouton Modifier pour modifier nom de profil
                                    Button("Modifier") {
                                        oldName = viewModel.utilisateur.nom
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
                .onAppear {
                    url.loadImage(&image)
                }
            }
            
            Section {
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
                        Text("Toutes")
                            .tag("Toutes")
                            .font(.footnote)
                        ForEach(GlobalViewModel.shared.categories) { category in
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
                // Affichage des vidéos des favoris filtrées
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredFavoritedVideos, id: \.["title"]) { favorite in
                            if let fileName = favorite["title"], let url = URL(string: GlobalViewModel.shared.baseVideoURL + fileName + ".mp4") {
                                VideoThumbnailView(
                                    path: $path,
                                    favoriteVideoSelected: $favoriteVideoSelected,
                                    videoToPlay: url.absoluteString,
                                    currentPlayingVideo: $currentPlayingVideo
                                )
                            } else {
                                Text("Vidéo non trouvée")
                                    .frame(height: 180)
                                    .background(Color.red)
                            }
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUtilisateur()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Profil")
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
}


