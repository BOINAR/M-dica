//
//  ScannerView.swift
//  Medica
//
//  Created by Nayeff BOINARIZIKI on 12/03/2024.
//
import VisionKit
import Foundation
import SwiftUI


struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
     
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
     
    typealias UIViewControllerType = VNDocumentCameraViewController
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
     
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
         
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
         
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
