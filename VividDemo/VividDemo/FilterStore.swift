//
//  FilterStore.swift
//  VividDemo
//
//  Created by YuAo on 1/30/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import CoreImage

class FilterStore {
    static let filters: [CIFilter?] = {
        var filters = [CIFilter?]()
        
        filters.append(nil)
        
        filters.append(CIFilter(
            name: "YUCIColorLookup",
            withInputParameters:[
                "inputColorLookupTable": CIImage(contentsOfURL: NSBundle.mainBundle().URLForResource("color_lookup_miss_etikate", withExtension: "png")!)!
            ])
        )
        
        filters.append(CIFilter(
            name: "YUCIRGBToneCurve",
            withInputParameters:[
                "inputRGBCompositeControlPoints": [CIVector(x: 0, y: 0),CIVector(x: 0.5, y: 0.7), CIVector(x: 1, y: 1)]
            ])
        )
        
        return filters
    }()
}
