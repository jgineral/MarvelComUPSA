//
//  ComicListView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI

struct ComicListView: View {
    @ObservedObject var viewModel: ComicListViewModel
    @State private var pickerSelection: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if viewModel.error != nil {
                        ErrorView(error: viewModel.error) {
                            viewModel.loadData()
                        }
                    } else {
                        list
                    }
                }
            }
            .onAppear {
                pickerSelection = viewModel.pickerSelection
                viewModel.loadData()
            }
        }
    }

    var picker: some View {
        Picker("Select an option", selection: $pickerSelection) {
            ForEach(viewModel.pickerOptions, id: \.self) {
                Text($0)
            }
        }
        .onChange(of: pickerSelection) { selection in
            viewModel.selectOption(option: selection)
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .padding()
    }

    var list: some View {
        VStack {
            picker
            List {
                ForEach(viewModel.list) { comic in
                    NavigationLink {
                        ComicDetailBuilder().build(comicId: comic.id)
                    } label: {
                        ComicItem(comic: comic)
                    }
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
        ComicListBuilderMock().build()
    }
}
