//
//  ContentView.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowPhotoLibrary = false
    @State var image: Image?
    @EnvironmentObject var classifier: ImageClassifier
    
    var body: some View {
        ZStack {
            PhotoFrame(image: $image)
            VStack {
                Spacer()
                Text(classifier.classificationLabel)
                LibraryButton(isShowLibrary: $isShowPhotoLibrary)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary, content: {
            PhotoPicker(isPresented: $isShowPhotoLibrary,
                        seledtedImage: $image)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImageClassifier())
    }
}
