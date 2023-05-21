//
//  ComicListView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI

struct ComicListView: View {
    @ObservedObject var viewModel: ComicListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                ProgressView().isHidden(!viewModel.isLoading)
                if viewModel.error != nil {
                    ErrorView(error: viewModel.error) {
                        viewModel.loadComics()
                    }
                } else {
                    list
                }
            }
        }.onAppear{ viewModel.loadComics() }
    }

    var list: some View {
        List {
            ForEach(viewModel.list) { comic in
                NavigationLink {
                    ComicDetailBuilder().build(comicId: comic.id)
                } label: {
                    ComicItem(comic: comic)
                }
            }
        }
        .navigationTitle(viewModel.title)
    }
}

struct ComicItem: View {
    @State var comic: ComicUIModel
    
    var body: some View {
        HStack {
            ImageView(url: comic.thumbnail)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(comic.title)
                    .font(.headline)
            }
            Spacer()
        }
    }
}

struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicListBuilder().build(mode: .favorites)
    }
}
