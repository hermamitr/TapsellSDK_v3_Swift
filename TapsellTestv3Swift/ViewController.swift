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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = TSConfiguration()
        config.setDebugMode(true);
        
        Tapsell.initialize(withAppKey: "ljrdhscbkpjrkslfljrjpgtbjjfdajgrlihaocnqsnplgmsckssqkogsfmfatlbjelbfcd", andConfig: config)
        
        Tapsell.setAdShowFinishedCallback { (ad, completed) in
            if(ad!.isRewardedAd() && completed){
                NSLog("Congratulations! awarded 1 coin.");
            }
        }
        
        let requestOptions = TSAdRequestOptions()
        requestOptions.setCacheType(CacheTypeCached)
        
        Tapsell.requestAd(forZone: "5913110746846551e1340acf", andOptions: requestOptions, onAdAvailable:{ (tapsellAd) in
            let showOptions = TSAdShowOptions()
            showOptions.setOrientation(OrientationUnlocked)
            showOptions.setBackDisabled(false)
            showOptions.setShowDialoged(true)
            tapsellAd?.show(with: showOptions)
            
        }, onNoAdAvailable: {
            NSLog("No Ad Available")
        }, onError: { (error) in
            NSLog("onError:"+error!)
        }, onExpiring: { (ad) in
            NSLog("Expiring")
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

