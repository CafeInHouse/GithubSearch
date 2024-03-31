//
//  CacheView.swift
//  [Product] GithubSearchApp
//
//  Created by saeng lin on 3/31/24.
//

import SwiftUI

import KUI

struct CacheView: View {
    
    @EnvironmentObject
    private var viewModel: CacheViewModel
    
    private let keywordAction: (String) async -> Void
    private let removeKeyword: (String) async -> Void
    private let removeAllAction: () async -> Void
    
    init(
        keywordAction: @escaping (String) async -> Void,
        removeKeyword: @escaping (String) async -> Void,
        removeAllAction: @escaping () async -> Void
    ) {
        self.keywordAction = keywordAction
        self.removeKeyword = removeKeyword
        self.removeAllAction = removeAllAction
    }
    
    var body: some View {
        bodyView
    }
    
    private var bodyView: some View {
        List {
            Section(header: Text("최근 검색")) {
                ForEach(viewModel.searchKeywordList, id: \.hashValue) { keyword in
                    HStack(spacing: .zero, content: {
                        KUIText(
                            text: keyword,
                            weight: .bold,
                            size: 15
                        )
                        .padding(.horizontal, 10)
                        .onExpandTapGesture {
                            Task { @MainActor in
                                await keywordAction(keyword)
                            }
                        }
                        
                        Button(action: {
                            Task { @MainActor in
                                await removeKeyword(keyword)
                            }
                        }, label: {
                            Image(systemName: "xmark.circle" )
                                .minimumScaleFactor(0.3)
                                .accentColor(.white)
                                .padding(10)
                        })
                        
                        Spacer()
                    })
                }
                
                if viewModel.searchKeywordList.isEmpty == false {
                    HStack(content: {
                        Spacer()
                        
                        KUIText(text: "모두 삭제", textColor: .kui.red, weight: .bold, size: 15)
                    })
                    .padding(.horizontal, 10)
                    .onExpandTapGesture {
                        Task { @MainActor in
                            await removeAllAction()
                        }
                    }
                }
            }
        }
    }
}
