![Vivid](https://raw.githubusercontent.com/YuAo/Vivid/master/Documentation/Assets/header.png)

![CocoaPods Platform](https://img.shields.io/cocoapods/p/Vivid.svg?style=flat-square)
![CocoaPods Version](https://img.shields.io/cocoapods/v/Vivid.svg?style=flat-square)
![CocoaPods License](https://img.shields.io/cocoapods/l/Vivid.svg?style=flat-square)

A set of custom filters and utilities for Apple's [Core Image](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html) framework.

Available on both OS X and iOS.

Involving...

##Core Image Filters

###Filters

####YUCIRGBToneCurve

Adjusts tone response of the R, G, and B channels of an image.

The filter takes in an array of control points that define the spline curve for each color component, or for all three in the composite.

These are stored as `CIVector`s in an `NSArray`, with normalized X and Y coordinates from `0` to `1`.

The defaults are `[(0,0), (0.5,0.5), (1,1)]`

####YUCIColorLookup

Uses a color lookup table (LUT) to remap the colors in an image. The default LUT can be found at `Sources/YUCIColorLookupTableDefault.png`

*This filter may not work well in the default light-linear working color space. Use `kCIContextWorkingColorSpace` key to specify a working color space when creating the `CIContext` object.*

####YUCISurfaceBlur

Blurs an image while preserving edges. This filter is almost identical to Photoshop's "Surface Blur" filter.

Useful for creating special effects and for removing noise or graininess. Slow on large `inputRadius`.

####YUCITriangularPixellate

Maps an image to colored triangles.

###Transitions

####YUCICrossZoomTransition

A transition that pushes the `inputImage` toward the viewer and then snaps back with the `inputTargetImage`.

####YUCIFlashTransition

Transitions from one image to another by creating a flash effect.

###Generators

####YUCIStarfieldGenerator

Generate a starfield image. Animatable by changing the `inputTime` parameter. Based on [Star Nest](https://www.shadertoy.com/view/XlfGRj) by Pablo Román Andrioli

####YUCIBlobsGenerator

Generate a image with colorful blobs. Animatable by changing the `inputTime` parameter. Based on [Blobs](https://www.shadertoy.com/view/lsfGzr) by [@paulofalcao](https://twitter.com/paulofalcao)

##Utilities

####YUCIFilterConstructor

A singleton that conforms to `CIFilterConstructor` protocol.

Can be used in `+[CIFilter registerFilterName:constructor:classAttributes:]` to register a `CIFilter`. This filter constructor simply assume that the `filterName` is the class name of the custom `CIFilter` and calls `[[FilterClass alloc] init]` to construct a filter.

####YUCIMetalUtilities

`+[YUCIMetalUtilities textureFromCGImage:device:]`

Create a `MTLTexture` from a `CGImageRef` object.

##Next

- [ ] Add filter previews to readme.
- [ ] AA for triangular pixellate filter.
- [ ] CLAHE

##Based on Vivid

####[YUCIHighPassSkinSmoothing](https://github.com/YuAo/YUCIHighPassSkinSmoothing)

An implementation of High Pass Skin Smoothing
