//
//  NativeAdController.swift
//  TapsellTestv3Swift
//
//  Created by Tapsell on 2/10/18.
//  Copyright © 2018 Tapsell. All rights reserved.
//

import Foundation
import UIKit
import TapsellSDKv3

class NativeAdController : UIViewController {
    
    @IBOutlet var nativeVideo: TSNativeVideoAdView!
    @IBOutlet var nativeBanner: TSNativeBannerAdView!
    @IBOutlet var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        nativeBanner.isHidden = true;
        nativeVideo.isHidden = true;
        nativeBanner.titleLabelTag = 100;
        nativeBanner.descriptionLabelTag = 101;
        nativeBanner.logoImageTag = 102;
        nativeBanner.mainImageTag = 103;
        nativeBanner.callToActionButtonTag = 104;
        nativeVideo.titleLabelTag = 1000;
        nativeVideo.descriptionLabelTag = 1001;
        nativeVideo.logoImageTag = 1002;
        nativeVideo.videoViewTag = 1003;
        nativeVideo.callToActionButtonTag = 1004;
    }
    
    @IBAction func nativeBannerClicked(_ sender: Any) {
        nativeVideo.isHidden = true
        nativeBanner.isHidden = false
        Tapsell.requestNativeBannerAd(forZone: "5a8401093194ec0001bb1059",
                                      andContainerView: nativeBanner,
                                      onRequestFilled: {print("native banner filled")},
                                      onNoAdAvailable: { print("no native banner available")},
                                      onError: { (error) in print("error: ", error ?? "Null")})

    }
    
    @IBAction func nativeVideoClicked(_ sender: Any) {
        nativeVideo.isHidden = false
        nativeBanner.isHidden = true
        Tapsell.requestNativeVideoAd(forZone: "5a844bd6d612ee0001004566",
                                      andContainerView: nativeVideo,
                                      onRequestFilled: {print("native video filled")},
                                      onNoAdAvailable: { print("no native video available")},
                                      onError: { (error) in print("error: ", error ?? "Null")})

    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
}
