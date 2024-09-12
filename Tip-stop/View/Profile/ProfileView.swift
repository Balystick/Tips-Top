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
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel: ProfileViewModel
    @State private var selectedCategory = "Productivité"
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private var url: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("image.jpg")
    }
    
    @State private var isModify = false
    @State private var isCancel = false
    @State private var isValidate = false
    @State private var failedEnterName = false
    @State private var showingAlert = false
    @State private var showAlert = false
    @State private var oldName: String = ""
    @State private var newName: String = ""
    
    // Updated video URL list from remote server
    let videoPaths = UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? []
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    @State private var currentPlayingVideo: String? = nil
    @Binding var favoriteVideoSelected: String?
    
    init(path: Binding<NavigationPath>, globalDataModel: GlobalDataModel, favoriteVideoSelected: Binding<String?>) {
        self._path = path
        self.globalDataModel = globalDataModel
        self._favoriteVideoSelected = favoriteVideoSelected
        let utilisateur = Utilisateur(nom: "", photo: nil, favoris: [])
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(globalDataModel: globalDataModel, favoris: [], utilisateur: utilisateur))
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
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
                            ZStack {
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
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, Image: self.$image)
                    }
                    .onChange(of: image) { oldValue, newValue in
                        viewModel.saveImage(newValue)
                    }
                    Spacer()
                    Spacer()
                    HStack {
                        VStack {
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
                                    Button(action: {
                                        viewModel.utilisateur.nom = oldName
                                        isCancel = true
                                        isModify = false
                                    }, label: {
                                        Text("Annuler")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .animation(.easeOut(duration: 0.2), value: isModify)
                                            .foregroundColor(.gray)
                                    })
                                    
                                    Button(action: {
                                        self.failedEnterName = false
                                        if self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3 {
                                            showingAlert.toggle()
                                            self.failedEnterName.toggle()
                                        } else {
                                            viewModel.addUtilisateur()
                                            newName = viewModel.utilisateur.nom
                                            viewModel.saveName(newName)
                                            oldName = viewModel.utilisateur.nom
                                            isValidate.toggle()
                                            isModify = false
                                            
                                            if oldName != newName {
                                                showAlert.toggle()
                                                isValidate.toggle()
                                                isModify = false
                                            }
                                        }
                                    }, label: {
                                        Text("Valider")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(Color(.customBlue))
                                    })
                                    .alert(isPresented: $showingAlert) {
                                        if self.failedEnterName {
                                            return Alert(title: Text("Le nom doit contenir au moins trois lettres"), message: Text("Veuillez modifier"), dismissButton: .default(Text("OK")))
                                        } else {
                                            return Alert(title: Text("Validé"), message: Text("Changé"), dismissButton: .default(Text("OK")))
                                        }
                                    }
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .scaleEffect(isModify ? 1.2 : 1)
                                    .animation(.easeOut(duration: 0.2), value: isModify)
                                }
                                .padding(.horizontal, 15)
                            } else {
                                if viewModel.utilisateur.nom.isEmpty {
                                    Text("Veuillez entrer votre nom")
                                        .foregroundColor(Color(.customMediumGray))
                                        .font(.caption)
                                } else {
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
                                    Button("Modifier") {
                                        oldName = viewModel.utilisateur.nom
                                        isModify = true
                                    }
                                    .font(.footnote)
                                    .fontWeight(.thin)
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
                    HStack {
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
                        .fontWeight(.bold)
                        .foregroundColor(Color(.customMediumGray))
                    Picker("Choisir une catégorie", selection: $selectedCategory) {
                        ForEach(globalDataModel.categories) { category in
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
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(videoPaths, id: \.self) { fileName in
                            let videoURLString = "https://www.balystick.fr/tipstop/\(fileName).mp4"
                            if let videoURL = URL(string: videoURLString) {
                                VideoThumbnailView(path: $path, favoriteVideoSelected: $favoriteVideoSelected, videoToPlay: videoURL.absoluteString, currentPlayingVideo: $currentPlayingVideo)
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
