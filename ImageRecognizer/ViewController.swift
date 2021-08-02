//
//  ViewController.swift
//  ImageRecognizer
//
//  Created by Santiago Gómez Giraldo - Ceiba Software on 2/08/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var resnetModel = Resnet50()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        guard let image = imageView.image else { return }
        classifyPicture(image: image)
    }
    @IBAction func albumTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func classifyPicture(image: UIImage) {
        guard let model = try? VNCoreMLModel(for: resnetModel.model) else { return }
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else { return }
            let result = results[0]
            self.navigationController?.navigationBar.topItem?.title = result.identifier
        }
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let handler = VNImageRequestHandler(data: imageData, options: [:])
        try? handler.perform([request])
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        classifyPicture(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
}
