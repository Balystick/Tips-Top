import SwiftUI

struct InfiniteScrollView: View {
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel = InfiniteScrollViewModel()
    @State var categoryTitre: String
    @State private var currentIndex: Int = 0
    @State private var showingSheet = false
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                TabView(selection: $currentIndex) {
                    // La recommandation des vidéos par suivi des intéractions utilisateur - recommendVideos() - et la suggestion par nouveautés ne sont pas implémentées pour le moment
                    ForEach(Array(viewModel.astuces.enumerated().filter {$0.element.categorie.titre == categoryTitre || categoryTitre.isEmpty || categoryTitre == "Nouveautés"}), id: \.element.id) { index, astuce in
                        AstuceView(astuce: astuce, hasSeenOnboarding: $hasSeenOnboarding)
                            .tag(index)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .onAppear {
                                if index == viewModel.astuces.count - 1 {
                                    viewModel.loadMoreAstuces()
                                }
                            }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
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
                        path.append("ProfileView")
                        print(UserDefaults.standard.stringArray(forKey: "favoritedTitles") ?? [])
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
                    .padding(.trailing, 15)
                }
                Spacer()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

//#Preview {
//    InfiniteScrollView(categoryTitre: "Catégorie")
//}
