//
//  SearchViewModel.swift
//  GithubSearchApp
//
//  Created by saeng lin on 3/30/24.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    @Published private(set) var searchItems: [SearchItemModel] = []
    @Published private(set) var selectedItem: SearchItemModel?
    
    init(searchItems: [SearchItemModel]) {
        self.searchItems = searchItems
    }
}

extension SearchViewModel {
    
    func onRowTapped(item: SearchItemModel?) async {
        await MainActor.run { [weak self] in
            self?.selectedItem = item
        }
    }
}
