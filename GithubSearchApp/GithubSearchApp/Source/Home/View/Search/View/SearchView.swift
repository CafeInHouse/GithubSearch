//
//  SearchView.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import SwiftUI

import KUI

import Kingfisher

struct SearchView: View {
    
    @EnvironmentObject
    private var viewModel: SearchViewModel

    var body: some View {
        bodyView
    }
    
    private var bodyView: some View {
        List {
            Section(header: Text("\(viewModel.searchItems.count)개 저장소")) {
                ForEach(viewModel.searchItems, id:\.id) { item in
                    HStack(content: {
                        KFImage(item.owner.thumbnail)
                            .placeholder { _ in
                                Color.kui.black
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                        VStack(spacing: 10, content: {
                            HStack(spacing: .zero, content: {
                                KUIText(
                                    text: "\(item.name)",
                                    weight: .bold,
                                    size: 15
                                )
                                .padding(.horizontal, 10)
                                
                                Spacer()
                            })
                            
                            HStack(spacing: .zero, content: {
                                
                                KUIText(
                                    text: "\(item.owner.description)",
                                    weight: .light,
                                    size: 10
                                )
                                .padding(.horizontal, 10)
                                
                                Spacer()
                            })
                        })
                    })
                    .frame(maxHeight: 150)
                    .onExpandTapGesture {
                        Task {
                            await viewModel.onRowTapped(item: item)
                        }
                    }
                }
                .navigationDestination(isPresented: .init(get: {
                    return viewModel.selectedItem != nil
                }, set: { flag in
                    if flag == false {
                        Task {
                            await viewModel.onRowTapped(item: nil)
                        }
                    }
                })) {
                    KWebView(url: viewModel.selectedItem?.owner.url)
                        .navigationTitle(viewModel.selectedItem?.name ?? "")
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#Preview {
    SearchView()
        .environmentObject(SearchViewModel(searchItems: [
            .init(
                id: 123123,
                name: "린생",
                owner: .init(
                    id: 123123,
                    thumbnail: URL(string: "https://avatars.githubusercontent.com/u/70850251?v=4")!,
                    url: URL(string: "https://www.naver.com")!,
                    description: "상세"
                )),
            .init(
                id: 123121231233,
                name: "린생_2",
                owner: .init(
                    id: 123123123123123,
                    thumbnail: URL(string: "https://avatars.githubusercontent.com/u/70850251?v=4")!,
                    url: URL(string: "https://www.naver.com")!,
                    description: "상세_2"
                ))
        ]))
}
