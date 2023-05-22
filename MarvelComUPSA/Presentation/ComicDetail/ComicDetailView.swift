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
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        if let detail = viewModel.detail {
                            ImageView(url: detail.image)
                                .frame(width: 200, height: 200)
                            Text(detail.title)
                                .font(.title)
                            Button {
                                viewModel.updateFavorite()
                            } label: {
                                Label(viewModel.buttonTitle,
                                      systemImage: viewModel.buttonImage)
                                    .tint(.yellow)
                            }
                            creatorSection
                                .isHidden(detail.creators.isEmpty)
                            dateSection
                                .isHidden(detail.dates.isEmpty)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(CustomColors.detailColor)
        .onAppear { viewModel.loadComic() }
    }
    
    var creatorSection: some View {
        Section(viewModel.configuration.creatorsSectionTitle) {
            if let detail = viewModel.detail {
                ForEach(detail.creators) { creator in
                    HStack(spacing: 8) {
                        VStack(alignment: .leading) {
                            Text(viewModel.configuration.creatorsName)
                                .font(.body)
                            Text(viewModel.configuration.creatorsRole)
                                .font(.body)
                        }
                        VStack(alignment: .leading) {
                            Text(creator.name)
                                .font(.headline)
                            Text(creator.role)
                                .font(.headline)
                                .foregroundColor(creator.color)
                        }
                    }
                    .padding()
                }
            }
        }
    }
        
    var dateSection: some View {
        Section(viewModel.configuration.dateSectionTitle) {
            if let detail = viewModel.detail {
                ForEach(detail.dates) { date in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text(date.type)
                                .font(.body)
                            Text(date.date)
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailBuilderMock().build(comicId: 1)
    }
}
