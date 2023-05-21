//
//  ContentView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ComicListBuilder().build()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
