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
    weak var tapsellAd : TapsellAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = TSConfiguration()
        config.setDebugMode(true);
        
        Tapsell.initialize(withAppKey: "jtbrlocfkhffdtsndjnftchlqkaqakommthnhpresikasoqmodtdqkklhdbtjtfgahckdi", andConfig: config)
        
        self.btnShowAd.isHidden = true
        self.btnRequestAd.titleLabel?.numberOfLines = 0
        self.btnRequestAd.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        Tapsell.setAdShowFinishedCallback { (ad, completed) in
            if(ad!.isRewardedAd() && completed){
                NSLog("Congratulations! awarded 1 coin.");
            }
        }
        
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
            requestOptions.setCacheType(CacheTypeCached)
            
            Tapsell.requestAd(forZone: "5948d769468465339df23e02", andOptions: requestOptions, onAdAvailable:{ (tapsellAd) in
                
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
            tapsellAd?.show(with: showOptions)
            self.btnShowAd.isHidden = true
            self.btnRequestAd.setTitle("Request Ad", for: .normal)
        }

    }

}

