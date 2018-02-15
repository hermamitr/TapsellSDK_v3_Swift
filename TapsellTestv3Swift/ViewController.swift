//
//  ViewController.swift
//  TapsellTestv3Swift
//
//  Created by Tapsell on 5/29/17.
//  Copyright © 2017 Tapsell. All rights reserved.
//

import UIKit
import TapsellSDKv3

class ViewController: UIViewController {

    @IBOutlet weak var btnRequestAd: UIButton!
    @IBOutlet weak var btnShowAd: UIButton!
    @IBOutlet var bannerView: TSBannerAdView!
    weak var tapsellAd : TapsellAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = TSConfiguration()
        config.setDebugMode(true);
        
        Tapsell.initialize(withAppKey: "mioeqormndnommjqoapteerhkhccdttralkisksfabprknrthaagbofcohiojadbiqhcrc", andConfig: config)
        
        
        self.btnShowAd.isHidden = true
        self.btnRequestAd.titleLabel?.numberOfLines = 0
        self.btnRequestAd.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        Tapsell.setAdShowFinishedCallback { (ad, completed) in
            if(ad!.isRewardedAd() && completed){
                NSLog("Congratulations! awarded 1 coin.");
            }
        }
        
        bannerView.loadAd(withZoneId: "5a844ceeada66f0001edb032", andBannerType: 1, onRequestFilled: {
            NSLog("Banner ad filled");
        }, onHideBannerClicked: {
            NSLog("Banner Ad view is hidden!");
        }, onNoAdAvailable: {
            NSLog("No standard banner available");
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func requestAdClicked(_ sender: Any) {
        if(self.tapsellAd == nil)
        {
            self.btnRequestAd.setTitle("Fetching...", for: .normal)
            let requestOptions = TSAdRequestOptions()
            requestOptions.setCacheType(CacheTypeStreamed)
            
            Tapsell.requestAd(forZone: "592be81646846575539c6a25", andOptions: requestOptions, onAdAvailable:{ (tapsellAd) in
                
                NSLog("Ad Available")
                self.tapsellAd = tapsellAd
                DispatchQueue.main.async {
                    self.btnShowAd.isHidden = false
                    self.btnRequestAd.setTitle("Ready", for: .normal)
                }
            }, onNoAdAvailable: {
                NSLog("No Ad Available")
                DispatchQueue.main.async {
                    self.btnRequestAd.setTitle("No ad available,\nClick to Retry", for: .normal)
                }
            }, onError: { (error) in
                NSLog("onError:"+error!)
                DispatchQueue.main.async {
                    self.btnRequestAd.setTitle("Error occured,\nClick to Retry", for: .normal)
                }
            }, onExpiring: { (ad) in
                NSLog("Expiring")
            })
        }
    }

    @IBAction func showAdClicked(_ sender: Any) {
        if(self.tapsellAd != nil)
        {
            let showOptions = TSAdShowOptions()
            showOptions.setOrientation(OrientationUnlocked)
            showOptions.setBackDisabled(false)
            showOptions.setShowDialoge(true)
            tapsellAd?.show(with: showOptions, andOpenedCallback: { (tapsellAd) in
                NSLog("Ad Opened");
            }, andClosedCallback: { (tapsellAd) in
                NSLog("Ad Closed");
            })
            self.btnShowAd.isHidden = true
            self.btnRequestAd.setTitle("Request Ad", for: .normal)
        }

    }
    
    @IBAction func nativeAdClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NativeAd", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NativeAdController")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func nativeAdListClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NativeAdList", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NativeAdListController")
        self.present(controller, animated: true, completion: nil)
    }

}

