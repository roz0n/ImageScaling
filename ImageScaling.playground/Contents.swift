import UIKit

extension UIImage {
  
  func scaleLikeCavemen(to newSize: CGSize) -> UIImage {
    let image = UIGraphicsImageRenderer(size: newSize).image { _ in
      draw(in: CGRect(origin: .zero, size: newSize))
    }
    
    return image.withRenderingMode(renderingMode)
  }
  
  func scaleToPercent(_ percent: CGFloat) -> UIImage {
    let newWidth: CGFloat = self.size.width * (percent / 100)
    let newHeight: CGFloat = self.size.height * (percent / 100)
    
    let newSize = CGSize(width: newWidth, height: newHeight)
    let renderer = UIGraphicsImageRenderer(size: newSize)
    
    let scaledImage = renderer.image { _ in
      self.draw(in: CGRect(origin: .zero, size: newSize))
    }
    
    return scaledImage
  }
  
  func scaleMaintainingAspectRatio(to targetSize: CGSize) -> UIImage {
    // Compute the scaling ratio for the width and height separately
    let widthScaleRatio = targetSize.width / self.size.width
    let heightScaleRatio = targetSize.height / self.size.height
    
    // To keep the aspect ratio, scale by the smaller scaling ratio
    let scaleFactor = min(widthScaleRatio, heightScaleRatio)
    
    /*
     Multiply the original image’s dimensions by the scale factor
     to determine the scaled image size that preserves aspect ratio
     */
    let scaledImageSize = CGSize(
      width: self.size.width * scaleFactor,
      height: self.size.height * scaleFactor
    )
    
    let scaledImage = UIGraphicsImageRenderer(size: scaledImageSize).image { _ in
      self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
    }
    
    return scaledImage
  }
  
}

// MARK: - Load Image

let url = URL(string: "https://i.imgur.com/LgiOqsY.jpg")!
let data = try? Data(contentsOf: url)
let image = UIImage(data: data!)

// MARK: - Scale Image

let scaledLikeCavemen = image?.scaleLikeCavemen(to: CGSize(width: 100, height: 100))
let scaledToPercentage = image?.scaleToPercent(85)
let scledMaintainingAspect = image?.scaleMaintainingAspectRatio(to: CGSize(width: 350, height: 350))
