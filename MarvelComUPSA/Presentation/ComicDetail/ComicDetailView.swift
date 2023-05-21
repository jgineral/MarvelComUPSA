//
//  ComicDetailView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI

struct ComicDetailView: View {
    @ObservedObject var viewModel: ComicDetailViewModel
    
    var body: some View {
        ZStack {
            ProgressView().isHidden(!viewModel.isLoading)
            ScrollView {
                VStack(spacing: 8) {
                    if let detail = viewModel.detail {
                        ImageView(url: detail.image)
                            .frame(width: 200, height: 200)
                        Text(detail.title)
                            .font(.title)
                        creatorSection
                            .isHidden(detail.creators.isEmpty)
                        dateSection
                            .isHidden(detail.dates.isEmpty)
                    }
                }
                .padding()
            }
        }
        .onAppear { viewModel.loadComic() }
    }
    
    var creatorSection: some View {
        Section("Creators") {
            if let detail = viewModel.detail {
                ForEach(detail.creators) { creator in
                    VStack {
                        HStack {
                            Text("Nombre")
                                .font(.body)
                            Text(creator.name)
                                .font(.headline)
                            Spacer()
                        }
                        HStack {
                            Text("Rol")
                                .font(.body)
                            Text(creator.role.localizedUppercase)
                                .font(.headline)
                                .foregroundColor(creator.color)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
        
    var dateSection: some View {
        Section("Dates") {
            if let detail = viewModel.detail {
                ForEach(detail.dates) { date in
                    VStack {
                        HStack {
                            Text(date.type.localizedUppercase)
                                .font(.body)
                            Text(date.date)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailBuilder().build(comicId: 1)
    }
}
