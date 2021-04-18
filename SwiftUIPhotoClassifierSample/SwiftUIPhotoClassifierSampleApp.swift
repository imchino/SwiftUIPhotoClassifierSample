//
//  SwiftUIPhotoClassifierSampleApp.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import SwiftUI

@main
struct SwiftUIPhotoClassifierSampleApp: App {
    @StateObject var model = ImageClassifier()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
