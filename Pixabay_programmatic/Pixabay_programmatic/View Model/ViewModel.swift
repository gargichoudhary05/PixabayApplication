
import Foundation
import UIKit

protocol ImageViewModelDelegate{
    func imageDataUpdate()
}
class ImageViewModel {
  var images: [ImageData] = []
  private var currPage = 1
  var isLoadingTop = false
  var isLoadingBottom = false
  private let networking: ImageNetworkingProtocol

  init(networking: ImageNetworkingProtocol) {
          self.networking = networking
      }

  var delegate: ImageViewModelDelegate?

  func loadImages() {
    if isLoadingTop || isLoadingBottom {
      return
    }

    if images.isEmpty {
      isLoadingTop = true
      flagTop = true

    } else {
      isLoadingBottom = true
    }

       networking.getImagesData(query: "yellow flowers", page: currPage) { result in
        switch result {
        case .success(let newImages):
          if self.images.isEmpty {
            self.images = newImages
          } else {
            self.images.append(contentsOf: newImages)
          }
          self.currPage += 1
          self.isLoadingTop = false
          self.isLoadingBottom = false
          self.delegate?.imageDataUpdate()

        case .failure(let error):
          print("Error: \(error)")
//          self.isLoadingTop = false
//          self.isLoadingBottom = false
        }
      }
    }

    func loadMoreImages() {
      loadImages()
    }

  }

