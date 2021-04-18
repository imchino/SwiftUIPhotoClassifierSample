//
//  PhotoPicker.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var seledtedImage: Image?

    @EnvironmentObject var model: ImageClassifier   // for Image Classifier
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPresented = false

            let itemProvider = results.first?.itemProvider  // itemProvider is NSItemProvider? Type.

            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let uiImage = image as? UIImage {
                        self.parent.seledtedImage = Image(uiImage: uiImage)
                        self.parent.model.classifications(for: uiImage)     // for Image Classifier
                    }
                }
            }
        }
    }
}
