//
//  InfiniteScroll.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI

struct InfiniteScrollView: View {
    var categorieTitre: String

    var body: some View {
        Text("Infinite Scroll View for Category : \(categorieTitre)")
            .navigationTitle("Infinite Scroll")
    }
}

#Preview {
    InfiniteScrollView(categorieTitre: String())
}
