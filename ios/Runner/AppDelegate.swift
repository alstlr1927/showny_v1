import UIKit
import Flutter
import Photos
import NaverThirdPartyLogin

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "showny_channel/gallery"

  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)

      guard let controller : FlutterViewController = window?.rootViewController as? FlutterViewController else {
        fatalError("rootViewController is not type FlutterViewController")
      }
      
      let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        
      channel.setMethodCallHandler { [weak self] (call, result) in
          if call.method == "getGalleryImages" {
              self?.getGalleryImages(result: result)
          } else {
              result(FlutterMethodNotImplemented)
          }
      }
    
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if url.absoluteString.hasPrefix("kakao"){
      super.application(app, open:url, options: options)
      return true
    } else if url.absoluteString.contains("thirdPartyLoginResult") {
      NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
      return true
    } else {
      return true
    }
  }

  private func getGalleryImages(result: @escaping FlutterResult) {
    var imageUrls = [String]()
    let fetchOptions = PHFetchOptions()
    // iOS 10.0 미만에서는 fetchOffset과 fetchLimit을 사용할 수 없음

    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

    let imageManager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = true
    requestOptions.deliveryMode = .highQualityFormat

    let totalAssetCount = fetchResult.count
    let pageSize = 20 // 한 페이지당 로드할 이미지 수
    let pageIndex = 0 // 페이지 인덱스 (이 예시에서는 첫 페이지)
    let startIndex = pageIndex * pageSize
    let endIndex = min((startIndex + pageSize), totalAssetCount)

    for i in startIndex..<endIndex {
        let asset = fetchResult.object(at: i)
        imageManager.requestImageData(for: asset, options: requestOptions) { (_, _, _, info) in
            if let info = info, let fileUrl = info["PHImageFileURLKey"] as? URL {
                imageUrls.append(fileUrl.absoluteString)
            }

            if i == endIndex - 1 {
                result(imageUrls)
            }
        }
    }
  }
}
