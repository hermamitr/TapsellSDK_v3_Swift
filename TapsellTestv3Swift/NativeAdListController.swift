//
//  NativeAdListController.swift
//  TapsellTestv3Swift
//
//  Created by Tapsell on 2/15/18.
//  Copyright © 2018 Tapsell. All rights reserved.
//

import Foundation
import UIKit
import TapsellSDKv3

class NativeAdListController : UIViewController ,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView : UITableView!
    var listData: NSMutableArray!
    var nativeBanner : TSNativeBannerAdView!
    var nativeVideo : TSNativeVideoAdView!
    var nativeBannerBundle : TSNativeBannerBundle!
    var nativeVideoBundle : TSNativeVideoBundle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listData = NSMutableArray.init(array: ["item1","item1","item1","item1","item1","item1","bannerAd","item1","item1","item1","item1","videoAd","item1","item1"])
        let nib : NSArray = Bundle.main.loadNibNamed("NativeBannerTableCell", owner: self, options: nil)! as NSArray
        let cell : NativeBannerTableCellTableViewCell! = nib[0] as! NativeBannerTableCellTableViewCell
        nativeBanner = cell.nativeBanner
        
        Tapsell.requestNativeBannerAd(forZone: "5a8401093194ec0001bb1059",
                                      andContainerView: nativeBanner,
                                      onRequestFilled: {
                                        print("native banner filled")
                                        self.nativeBannerBundle = self.nativeBanner.getBundle()
                                    },
                                      onNoAdAvailable: { print("no native banner available")},
                                      onError: { (error) in print("error: ", error ?? "Null")})
        
        let nibV : NSArray = Bundle.main.loadNibNamed("NativeVideoTableCell", owner: self, options: nil)! as NSArray
        let cellV : NativeVideoTableViewCell! = nibV[0] as! NativeVideoTableViewCell
        nativeVideo = cellV.nativeVideo
        Tapsell.requestNativeVideoAd(forZone: "5a844bd6d612ee0001004566",
                                     andContainerView: nativeVideo,
                                     onRequestFilled: {print("native video filled")
                                        self.nativeVideoBundle = self.nativeVideo.getBundle()},
                                     onNoAdAvailable: { print("no native video available")},
                                     onError: { (error) in print("error: ", error ?? "Null")})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 6) {
            let cell : NativeBannerTableCellTableViewCell! = Bundle.main.loadNibNamed("NativeBannerTableCell", owner: self, options: nil)![0] as! NativeBannerTableCellTableViewCell
            cell.nativeBanner.fill(with: nativeBannerBundle)
            return cell;
        }
        else if(indexPath.row == 12) {
            let cell : NativeVideoTableViewCell! = Bundle.main.loadNibNamed("NativeVideoTableCell", owner: self, options: nil)![0] as! NativeVideoTableViewCell
            cell.nativeVideo.fill(with: nativeVideoBundle)
            return cell;
        }
        else {
            let cell : NativeBannerTableCellTableViewCell! = Bundle.main.loadNibNamed("NativeBannerTableCell", owner: self, options: nil)![0] as! NativeBannerTableCellTableViewCell

            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 12) {
            return 281
        }
        return 232
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
