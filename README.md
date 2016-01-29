# Vivid

![CocoaPods Platform](https://img.shields.io/cocoapods/p/Vivid.svg?style=flat-square)
![CocoaPods Version](https://img.shields.io/cocoapods/v/Vivid.svg?style=flat-square)
![CocoaPods License](https://img.shields.io/cocoapods/l/Vivid.svg?style=flat-square)

A set of custom filters and utilities for Apple's [Core Image](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html) framework.

Available on both OS X and iOS.

##Filters

####YUCIRGBToneCurve

Adjusts tone response of the R, G, and B channels of an image.

The filter takes in an array of control points that define the spline curve for each color component, or for all three in the composite.

These are stored as `CIVector`s in an `NSArray`, with normalized X and Y coordinates from `0` to `1`.

The defaults are `[(0,0), (0.5,0.5), (1,1)]`

*This filter may not work well in the default light-linear working color space. Use `kCIContextWorkingColorSpace` key to specify a working color space when creating the `CIContext` object.*

####YUCIColorLookup

Uses a color lookup table (LUT) to remap the colors in an image. The default LUT can be found at `Sources/YUCIColorLookupTableDefault.png`

*This filter may not work well in the default light-linear working color space. Use `kCIContextWorkingColorSpace` key to specify a working color space when creating the `CIContext` object.*

##Utilities

####YUCIFilterConstructor

A singleton that conforms to `CIFilterConstructor` protocol.

Can be used in `+[CIFilter registerFilterName:constructor:classAttributes:]` to register a `CIFilter`. This filter constructor simply assume that the `filterName` is the class name of the custom `CIFilter` and calls `[[FilterClass alloc] init]` to construct a filter.

####YUCIMetalUtilities

`+[YUCIMetalUtilities textureFromCGImage:device:]`

Create a `MTLTexture` from a `CGImageRef` object.

##Based on Vivid

####[YUCIHighPassSkinSmoothing](https://github.com/YuAo/YUCIHighPassSkinSmoothing)

An implementation of High Pass Skin Smoothing
