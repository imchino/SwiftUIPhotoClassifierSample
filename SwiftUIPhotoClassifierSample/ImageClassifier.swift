//
//  ImageClassifier.swift
//  SwiftUIPhotoClassifierSample
//
//  Created by chino on 2021/04/17.
//

import Foundation
import Vision
import UIKit

class ImageClassifier: ObservableObject {
    @Published var classificationLabel = "No Picture"
    let model: VNCoreMLModel

    init() {
        // モデルのインスタンスを作成
        let modelURL = Bundle.main.url(forResource: "MobileNetV2", withExtension: "mlmodelc")!
        model = try! VNCoreMLModel(for: MobileNetV2(contentsOf: modelURL).model)
    }

    func classifications(for image: UIImage) {
        classificationLabel = "Classifying..."

        // 写真の方向を取得する
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        // UIImage型をCIImage型に変換
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }

        // グローバルキューでハンドラを作成して実行
        DispatchQueue.global(qos: .userInitiated).async {
            // リクエストを作成
            let request = VNCoreMLRequest(model: self.model, completionHandler: { (request, error) in
                self.processClassifications(for: request, error: error)     // リクエストの完了ハンドラ
            })
            // 写真のをモデル指定のサイズに切り取る
            request.imageCropAndScaleOption = .centerCrop

            // リクエストハンドラを作成して、リクエストを実行する
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            try! handler.perform([request])
        }
    }

    // リクエストのコールバックでやること
    func processClassifications(for request: VNRequest, error: Error?) {
        // メインキューでリクエストの結果を処理する
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            // resultsの型は常に、VNClassificationObservationのコレクション
            let classifications = results as! [VNClassificationObservation]

            if classifications.isEmpty {
                self.classificationLabel = "Nothing recognized."
            } else {
                // 確度が高い順に分類を表示する
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                   // 分類の表示形式: "(0.37) cliff, drop, drop-off"
                   return String(format: "(%.2f) %@", classification.confidence, classification.identifier)
                }
                // Published属性プロパティを変更して、ビューのラベルを更新
                self.classificationLabel = descriptions.joined(separator: "\n")
            }
        }
    }
}
