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
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel = InfiniteScrollViewModel()
    // Le titre de la catégorie actuellement sélectionnée
    @State var categoryTitre: String
    // Index actuel du TabView pour savoir quelle vidéo est en cours de lecture
    @State private var currentIndex: Int = 0
    // Index actuel du TabView pour sauvegarde/restauration lors de la navigation vers/depuis ProfileView
    @State private var lastPlayedIndex: Int?
    @Binding var favoriteVideoSelected: String?
    @Binding var hasSeenOnboarding: Bool
    @State private var players: [Int: AVPlayer] = [:]
    @State private var isLiked: [Int: Bool] = [:]
    @State private var isFavorited: [Int: Bool] = [:]
    @State private var showingComments = false
    @State private var showingSteps = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.astuces.enumerated().filter {$0.element.categorie.titre == categoryTitre || categoryTitre.isEmpty || categoryTitre == "Nouveautés"}), id: \.element.id) { index, astuce in
                    AstuceView(
                        astuce: astuce,
                        currentIndex: $currentIndex,
                        index: index,
                        players: $players
                    )
                    .tag(index)
                    .onAppear {
                        if index == viewModel.astuces.count - 1 {
                            viewModel.loadMoreAstuces()
                        }
                        // Initialise l'état des likes pour chaque astuce
                        isLiked[index] = viewModel.getStoredLikeStatus(for: astuce.video)
                        // Initialise l'état des favoris pour chaque astuce
                        isFavorited[index] = viewModel.getStoredFavorite(for: astuce.video)
                        // Reprendre la vidéo si l'index correspond
                        if index == currentIndex {
                            playCurrentVideo(at: index)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onChange(of: currentIndex) { oldIndex, newIndex in
                // Si on revient en arrière, relancer la vidéo précédente
                if newIndex < oldIndex {
                    playCurrentVideo(at: newIndex)
                } else {
                    // Arrêter la vidéo à l'ancien index et jouer la nouvelle
                    stopAllVideos()
                    playCurrentVideo(at: newIndex)
                }
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
    
    private func insertAndPlayFavoriteVideo() {
        guard let favoriteVideoString = favoriteVideoSelected else { return }

        let favoriteVideoFileName = URL(string: favoriteVideoString)?.lastPathComponent.replacingOccurrences(of: ".mp4", with: "")

        // Trouve l'astuce correspondante dans la liste actuelle
        if let favoriteAstuce = viewModel.astuces.first(where: { $0.video == favoriteVideoFileName }) {
            
            // Retire l'astuce si elle existe déjà
            if let existingIndex = viewModel.astuces.firstIndex(where: { $0.video == favoriteAstuce.video }) {
                viewModel.astuces.remove(at: existingIndex)
                // Ajuste currentIndex si nécessaire
                if existingIndex <= currentIndex {
                    currentIndex = max(currentIndex - 1, 0)
                }
            }

            // Insére l'astuce à l'index calculé
            let insertIndex = min(currentIndex + 1, viewModel.astuces.count)
            viewModel.astuces.insert(favoriteAstuce, at: insertIndex)

            // Met à jour currentIndex pour pointer vers la nouvelle vidéo insérée
            currentIndex = insertIndex

            // Réinitialise les players pour la synchro
            resetPlayers()

            // Lit la vidéo à l'index courant après insertion
            DispatchQueue.main.async {
                playCurrentVideo(at: currentIndex)
            }

            // Réinitialise favoriteVideoSelected
            favoriteVideoSelected = nil
        }
    }

    private func resetPlayers() {
        // Réinitialise tous les players
        players.removeAll()

        // Réinitialise les players pour chaque vidéo
        for (index, astuce) in viewModel.astuces.enumerated() {
            let player = AVPlayer(url: URL(fileURLWithPath: astuce.video))
            players[index] = player
        }
    }

    private func playCurrentVideo(at index: Int) {
        // Vérifier que l'index est valide
        guard index >= 0 && index < viewModel.astuces.count else { return }

        // Stopp toutes les vidéos avant de lire celle à l'index donné
        stopAllVideos()

        // Joue la vidéo à l'index spécifié
        if let player = players[index] {
            player.play()
        }
    }

    private func stopAllVideos() {
        for (_, player) in players {
            player.pause()
            player.seek(to: .zero) // Remet à zéro les vidéos non lues
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
