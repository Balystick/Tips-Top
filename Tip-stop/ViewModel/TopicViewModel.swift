//
//  TopicViewModel.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import Foundation

class TopicViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var reponses: [Reponse] = []
    
    func fetchTopics()
    {
        guard let url = URL(string: "http://localhost:3000/topics") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedTopics = try JSONDecoder().decode([Topic].self, from: data)
                    DispatchQueue.main.async {
                        self.topics = decodedTopics
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    func fetchReponse()
    {
        guard let url = URL(string: "http://localhost:3000/reponses") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedReponse = try JSONDecoder().decode([Reponse].self, from: data)
                    DispatchQueue.main.async {
                        self.reponses = decodedReponse
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}





////
////  TopicViewModel.swift
////  Tip-stop
////
////  Created by Apprenant 122 on 18/07/2024.
////
//import Foundation
//
//class TopicViewModel {
//    @Published var topics: [Topic] = []
//    @Published var reponses: [Reponse] = []
//    
//    init(topics: [Topic], reponses: [Reponse]) {
//        self.topics = topics
//        self.reponses = reponses
//    }
//}
