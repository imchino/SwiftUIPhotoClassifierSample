//
//  LibraryButton.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import SwiftUI

struct LibraryButton: View {
    @Binding var isShowLibrary: Bool
    
    var body: some View {
        Button(action: {
            isShowLibrary = true
        }, label: {
            Text("Choose Photo")
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10.0)
        })
    }
}

struct LibraryButton_Previews: PreviewProvider {
    static var previews: some View {
        LibraryButton(isShowLibrary: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
