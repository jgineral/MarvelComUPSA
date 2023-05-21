//
//  View+Hidden.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
