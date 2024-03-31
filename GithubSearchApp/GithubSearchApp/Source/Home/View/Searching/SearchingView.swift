//
//  SearchingView.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/31/24.
//

import SwiftUI

import KUI

struct SearchingView: View {
    
    @EnvironmentObject
    private var viewModel: SearchingViewModel
    
    var body: some View {
        bodyView
    }
    
    private var bodyView: some View {
        List {
            ForEach(viewModel.keywordList, id: \.hashValue) { keyword in
                KUIText(
                    text: keyword,
                    weight: .bold,
                    size: 15
                )
                .padding(.horizontal, 10)
            }
        }
    }
}
