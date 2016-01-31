//
//  FilterPreviewViewController.swift
//  VividDemo
//
//  Created by YuAo on 1/30/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import Cocoa

class FilterPreviewViewController: NSViewController {
    @IBOutlet weak var imageView: NSImageView!
    
    let context = CIContext(options: [kCIContextWorkingColorSpace: CGColorSpaceCreateWithName(kCGColorSpaceSRGB)!])
    var inputCIImage: CIImage!
    
    var inputImage: NSImage!
    var processedImage: NSImage!
    
    var filter: CIFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputImage = NSImage(named: "sample.jpg")
        self.inputCIImage = CIImage(contentsOfURL: NSBundle.mainBundle().URLForResource("sample", withExtension: "jpg")!)
        self.renderImageWithFilter(nil)
    }
    
    func replaceInputImageWithItemAtURL(URL: NSURL) {
        self.inputImage = NSImage(contentsOfURL: URL)
        self.inputCIImage = CIImage(contentsOfURL: URL)
        self.renderImageWithFilter(self.filter)
    }
    
    func renderImageWithFilter(filter: CIFilter?) {
        self.filter = filter
        if let filter = filter {
            filter.setValue(self.inputCIImage, forKey: kCIInputImageKey)
            let outputCIImage = filter.outputImage!
            let outputCGImage = self.context.createCGImage(outputCIImage, fromRect: outputCIImage.extent)
            let outputNSImage = NSImage(CGImage: outputCGImage, size: outputCIImage.extent.size)
            self.processedImage = outputNSImage
        } else {
            self.processedImage = self.inputImage
        }
        self.imageView.image = self.processedImage
    }
    
    @IBAction func handleImageViewPress(sender: NSPressGestureRecognizer) {
        switch sender.state {
        case .Began:
            self.imageView.image = self.inputImage
        case .Ended:
            self.imageView.image = self.processedImage
        case .Cancelled:
            self.imageView.image = self.processedImage
        default:
            Void()
        }
    }    
}
