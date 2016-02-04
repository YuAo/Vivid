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
        
        self.imageView.layerUsesCoreImageFilters = true
        
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
            if filter.name.hasSuffix("Transition") {
                let transition = CATransition()
                transition.filter = filter
                transition.duration = 1.0
                self.processedImage = self.inputImage
                if self.inputImage == self.imageView.image {
                    transition.delegate = self
                    self.imageView.image = NSImage(named: "sample2.jpg")
                    //transition back
                } else {
                    self.imageView.image = self.inputImage
                }
                self.imageView.layer?.addAnimation(transition, forKey: kCATransition)
            } else if (filter.name.hasSuffix("Generator")) {
                let outputCIImage = filter.outputImage!
                let outputCGImage = self.context.createCGImage(outputCIImage, fromRect: outputCIImage.extent)
                let outputNSImage = NSImage(CGImage: outputCGImage, size: outputCIImage.extent.size)
                self.processedImage = outputNSImage
                self.imageView.image = self.processedImage
            } else {
                filter.setValue(self.inputCIImage, forKey: kCIInputImageKey)
                let outputCIImage = filter.outputImage!
                let outputCGImage = self.context.createCGImage(outputCIImage, fromRect: outputCIImage.extent)
                let outputNSImage = NSImage(CGImage: outputCGImage, size: outputCIImage.extent.size)
                self.processedImage = outputNSImage
                self.imageView.image = self.processedImage
            }
        } else {
            self.processedImage = self.inputImage
            self.imageView.image = self.processedImage
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let transition = CATransition()
        transition.filter = self.filter
        transition.duration = 1.0
        self.imageView.layer?.addAnimation(transition, forKey: kCATransition)
        self.imageView.image = self.inputImage
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
