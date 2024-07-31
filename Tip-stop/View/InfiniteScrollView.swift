//
//  InfiniteScroll.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI

struct InfiniteScrollView: View {
    var categoryID: UUID

    var body: some View {
        Text("Infinite Scroll View for Category ID: \(categoryID)")
            .navigationTitle("Infinite Scroll")
    }
}

#Preview {
    InfiniteScrollView(categoryID: UUID())
}
