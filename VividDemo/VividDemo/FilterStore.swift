//
//  FilterStore.swift
//  VividDemo
//
//  Created by YuAo on 1/30/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import CoreImage

class FilterItem {
    let name: String
    let filter: CIFilter?
    
    init(name: String, filter: CIFilter?) {
        self.name = name
        self.filter = filter
    }
}

class FilterStore {
    static let filters: [FilterItem] = {
        var filters = [FilterItem]()
        
        filters.append(FilterItem(name: "No Filter", filter: nil))
        
        filters.append(FilterItem(name: "Color Lookup", filter: CIFilter(
            name: "YUCIColorLookup",
            withInputParameters:[
                "inputColorLookupTable": CIImage(contentsOfURL: NSBundle.mainBundle().URLForResource("color_lookup_miss_etikate", withExtension: "png")!)!
            ]))
        )
        
        filters.append(FilterItem(name: "RGB Tone Curve", filter: CIFilter(
            name: "YUCIRGBToneCurve",
            withInputParameters:[
                "inputRGBCompositeControlPoints": [CIVector(x: 0, y: 0),CIVector(x: 0.5, y: 0.7), CIVector(x: 1, y: 1)]
            ]))
        )
        
        return filters
    }()
}
