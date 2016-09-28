//
//  InfoViewController.swift
//  VividDemo
//
//  Created by YuAo on 1/31/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import Cocoa

class InfoViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    
    var filter: CIFilter? {
        didSet {
            self.updateInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateInfo()
    }
    
    func updateInfo() {
        if self.isViewLoaded {
            let filterDescription: String
            if let filter = self.filter {
                var description = filter.name + "\n\n"
                for inputKey in filter.inputKeys {
                    if inputKey != kCIInputImageKey {
                        let value = filter.value(forKey: inputKey)
                        description += "\(inputKey): \(value != nil ? value! : "<null>")\n"
                    }
                }
                filterDescription = description
            } else {
                filterDescription = "No filter applied."
            }
            self.textField.stringValue = "Tip:\nLong press the preview image to compare.\n\nFilter:\n\(filterDescription)"
        }
    }
    
}
