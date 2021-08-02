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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var resnetModel = Resnet50()
        
        guard let image = imageView.image else { return }
        classifyPicture(image: image)
    }
    
    private func classifyPicture(image: UIImage) {
        
    }
}

