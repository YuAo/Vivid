//
//  MainWindowController.swift
//  VividDemo
//
//  Created by YuAo on 1/30/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var filtersToolbarItem: NSToolbarItem!
    @IBOutlet weak var filtersPopUpButton: NSPopUpButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.titleVisibility = .Hidden
        
        self.filtersToolbarItem.minSize.height = 32
        self.filtersPopUpButton.menu?.removeAllItems()
        for filter in FilterStore.filters {
            let filterName = (filter?.attributes[kCIAttributeFilterDisplayName] as? String) ?? "Unknown"
            let menuItem = NSMenuItem(title: (filter != nil ? filterName : "No Filter"), action: nil, keyEquivalent: "")
            menuItem.representedObject = filter
            self.filtersPopUpButton.menu?.addItem(menuItem)
        }
    }

    @IBAction func filtersPopUpButtonValueChanged(sender: NSPopUpButton) {
        let previewViewController = self.contentViewController as! FilterPreviewViewController
        let filter = sender.selectedItem?.representedObject as? CIFilter
        previewViewController.renderImageWithFilter(filter)
    }
    
    var openPanel: NSOpenPanel?
    
    @IBAction func chooseImageButtonClicked(sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = [kUTTypeJPEG as String, kUTTypePNG as String]
        openPanel.beginSheetModalForWindow(self.window!) { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                let URL = openPanel.URLs.first!
                let previewViewController = self.contentViewController as! FilterPreviewViewController
                previewViewController.replaceInputImageWithItemAtURL(URL)
            }
        }
        self.openPanel = openPanel
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationController {
        case let infoViewController as InfoViewController:
            let filter = self.filtersPopUpButton.selectedItem?.representedObject as? CIFilter
            infoViewController.filter = filter
        default:
            Void()
        }
    }
}
