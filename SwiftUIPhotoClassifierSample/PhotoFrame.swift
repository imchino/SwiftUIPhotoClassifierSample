//
//  PhotoFrame.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import SwiftUI

struct PhotoFrame: View {
    @Binding var image: Image?

    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "photo")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}
