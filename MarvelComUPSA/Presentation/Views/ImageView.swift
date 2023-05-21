//
//  ImageView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import SwiftUI

struct ImageView: View {
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
    }

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image(systemName: "photo.fill")
        }
        .clipShape(Circle())
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://dummyurl.com")
        ImageView(url: url)
    }
}
