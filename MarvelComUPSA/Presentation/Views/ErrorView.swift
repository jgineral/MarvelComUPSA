//
//  ErrorView.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import SwiftUI

struct ErrorView: View {
    private let error: String?
    private let completion: (() -> Void)
    
    init(error: String?, completion: @escaping () -> Void) {
        self.error = error
        self.completion = completion
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.circle.fill")
                .symbolRenderingMode(.multicolor)
            Text("Ha ocurrido un error - \(error ?? "")")
                .padding()
            Button {
                completion()
            } label: {
               Text("Intentar de nuevo")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error") {
            print("Test button")
        }
    }
}
