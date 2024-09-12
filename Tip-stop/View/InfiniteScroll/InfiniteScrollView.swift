//
//  InfiniteScrollView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024
//  Modified by Aurélien
//

import SwiftUI
import AVKit

/// `InfiniteScrollView` est une vue qui permet de parcourir une liste infinie d'astuces.
/// Elle affiche une liste de vidéos qui se chargent dynamiquement au fur et à mesure que l'utilisateur fait défiler.
struct InfiniteScrollView: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = InfiniteScrollViewModel()
    // Utilisée pour filtrer les astuces par catégorie
    @State var categoryTitre: String
    // Index actuel du TabView pour savoir quelle vidéo est en cours de lecture
    @State private var currentIndex: Int = 0
    // Index actuel du TabView pour sauvegarde/restauration de la dernière vidéo jouée lors de la navigation vers/depuis ProfileView
    @State private var lastPlayedIndex: Int?
    // Utilisée pour insérer et jouer la vidéo favorite
    @Binding var favoriteVideoSelected: String?
//    @Binding var hasSeenOnboarding: Bool
    // stocke les instances d’AVPlayer pour chaque vidéo
    @State private var players: [Int: AVPlayer] = [:]
    // suit l'état des likes pour chaque vidéo
    @State private var isLiked: [Int: Bool] = [:]
    // suit l’état des favoris pour chaque vidéo
    @State private var isFavorited: [Int: Bool] = [:]
    // utilisé pour l'affichage des commentaires
    @State private var showingComments = false
    // Utilisé pour l'affichage du step by step
    @State private var showingSteps = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            TabView(selection: $currentIndex) {
                // Pas assez de contenu pour activer les filtres pour le moment
                // ForEach(Array(viewModel.astuces.enumerated().filter {$0.element.categorie.titre == categoryTitre || categoryTitre.isEmpty || categoryTitre == "Nouveautés"}), id: \.element.id) { index, astuce in
                ForEach(Array(viewModel.astuces.enumerated()), id: \.element.id) { index, astuce in
                    AstuceView(
                        index: index,
                        players: $players
                    )
                    .tag(index)
                    .onAppear {
                        playCurrentVideo(at: index)
                        // Initialise l'état des likes pour chaque astuce
                        isLiked[index] = viewModel.getStoredLikeStatus(for: astuce.video)
                        // Initialise l'état des favoris pour chaque astuce
                        isFavorited[index] = viewModel.getStoredFavorite(for: astuce.video)
                    }
                    .onDisappear {
                        if let player = players[index] {
                            player.pause()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onChange(of: currentIndex) { oldIndex, newIndex in
                playCurrentVideo(at: newIndex)
            }
            
            VStack {
                Spacer().frame(height: 40)
                
                HStack {
                    Button(action: {
                        path.append("DecouverteView")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.001))
                                .frame(width: 75, height: 75)
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        lastPlayedIndex = currentIndex // Sauvegarde de l'index actuel
                        path.append("ProfileView")
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.001))
                                .frame(width: 75, height: 75)
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            toggleLike(at: currentIndex)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                VStack {
                                    Image(systemName: isLiked[currentIndex] == true ? "heart.fill" : "heart")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    Text("\(viewModel.astuces[currentIndex].nombreDeLikes)")
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .padding()
                            }
                        }
                        
                        Button(action: {
                            showingComments = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: "message")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            toggleFavorite(at: currentIndex)
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: isFavorited[currentIndex] == true ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        
                        Button(action: {
                            showingSteps.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black.opacity(0.001))
                                    .frame(width: 75, height: 75)
                                Image(systemName: "list.bullet.rectangle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 40)
                                    .padding(.top, 3)
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 15)
        }
        .onAppear {
            if favoriteVideoSelected != nil {
                // Si une vidéo favorite est sélectionnée, on l'insère et on la joue
                insertAndPlayFavoriteVideo()
            } else if let index = lastPlayedIndex {
                // Sinon, on restaure la vidéo précédemment jouée
                currentIndex = index
                DispatchQueue.main.async {
                    playCurrentVideo(at: index)
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .sheet(isPresented: $showingComments) {
            CommentaireView(commentaires: viewModel.astuces[currentIndex].commentaires)
        }
        .sheet(isPresented: $showingSteps) {
            StepsView()
        }
    }
    
    /// Insère une vidéo sélectionnée dans les favoris dans la liste et la joue
    private func insertAndPlayFavoriteVideo() {
        guard let favoriteVideoString = favoriteVideoSelected else {
            print("No favorite video selected")
            return
        }
        
        let favoriteVideoFileName = URL(string: favoriteVideoString)?.lastPathComponent.replacingOccurrences(of: ".mp4", with: "")
        
        if let favoriteAstuce = viewModel.astuces.first(where: { $0.video == favoriteVideoFileName }) {
            
            // Suppression de la vidéo si elle existe déjà dans la liste
            if let existingIndex = viewModel.astuces.firstIndex(where: { $0.video == favoriteAstuce.video }) {
                viewModel.astuces.remove(at: existingIndex)
                if existingIndex <= currentIndex {
                    currentIndex = max(currentIndex - 1, 0)
                }
            }
            
            // Insertion de la vidéo
            let insertIndex: Int
            if currentIndex == 0 {
                // Si on est sur la première vidéo : on l'insère avant la première vidéo
                insertIndex = 0
            } else {
                // Sinon : on l'insère après la dernière vidéo jouée
                insertIndex = min(currentIndex + 1, viewModel.astuces.count)
            }
            
            viewModel.astuces.insert(favoriteAstuce, at: insertIndex)
            
            currentIndex = insertIndex
            
            resetPlayers()
            
            DispatchQueue.main.async {
                playCurrentVideo(at: currentIndex)
            }
            
            // Réinitialisation de favoriteVideoSelected
            favoriteVideoSelected = nil
        }
    }
    
    /// Réinitialise les lecteurs vidéo (`AVPlayer`) pour toutes les vidéos présentes dans `viewModel.astuces`
    private func resetPlayers() {
        players.removeAll()
        for (index, astuce) in viewModel.astuces.enumerated() {
            if let videoURL = Bundle.main.url(forResource: astuce.video, withExtension: "mp4") {
                let player = AVPlayer(url: videoURL)
                players[index] = player
            }
        }
    }
    
    /// Joue la vidéo à l'index spécifié dans le `TabView`
    /// - Parameter index: L'index de la vidéo à jouer
    private func playCurrentVideo(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        stopAllVideos() // Arrête toutes les autres vidéos
        if let player = players[index] {
            player.play() // Joue la vidéo à l'index spécifié
        } else {
            loadVideo(for: index) // Charge et joue la vidéo si elle n'est pas déjà chargée
            players[index]?.play()
        }
    }
    
    /// Arrête toutes les vidéos en cours de lecture
    private func stopAllVideos() {
        for player in players.values {
            player.pause()
            player.seek(to: .zero) // Remet à zéro les vidéos non lues
        }
    }
    
    /// Charge la vidéo pour un index donné et initialise le lecteur vidéo (`AVPlayer`)
    /// - Parameter index: L'index de la vidéo à charger
    private func loadVideo(for index: Int) {
        let astuce = viewModel.astuces[index]
        let videoName = astuce.video
        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            let playerItem = AVPlayerItem(url: videoURL)
            let player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
            players[index] = player
            setupLooping(for: player)
        } else {
            // Gestion de l'erreur : la vidéo n'a pas pu être chargée
            print("Error: Video file \(videoName).mp4 not found in bundle.")
        }
    }
    
    /// Configure la lecture en boucle pour un lecteur vidéo (`AVPlayer`)
    /// - Parameter player: Le lecteur vidéo à configurer pour la lecture en boucle
    private func setupLooping(for player: AVPlayer) {
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }
    
    /// Alterne l'état du like de l'astuce à un index donné
    /// - Parameter index: L'index de l'astuce à liker ou dé-liker
    private func toggleLike(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        let astuce = viewModel.astuces[index]
        viewModel.toggleLike(for: astuce)
        
        isLiked[index] = viewModel.getStoredLikeStatus(for: astuce.video)
    }
    
    /// Alterne l'état de favori de l'astuce à un index donné
    /// - Parameter index: L'index de l'astuce à ajouter ou retirer des favoris
    private func toggleFavorite(at index: Int) {
        guard index >= 0 && index < viewModel.astuces.count else { return }
        
        let astuce = viewModel.astuces[index]
        viewModel.toggleFavorite(for: astuce)
        
        isFavorited[index] = viewModel.getStoredFavorite(for: astuce.video)
    }
    
}
