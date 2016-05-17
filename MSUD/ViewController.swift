//
//  ViewController.swift
//  MSUD
//
//  Created by Summon Yang on 16/5/12.
//  Copyright © 2016年 Summon. All rights reserved.
//

import UIKit
import BigInt

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var m: BigUInt!
        
//        m = BigUInt.randomIntegerWithExactWidth(1024)
        
        print("密钥生成......")
        let paillier = Paillier()
        paillier.kenGen()
        
        // 加密时间

        var c: BigUInt!
//        
//        m = BigUInt.init("9948296768586996505363263214281556682087771923934933409457547085461771441191821484747927272898437588177798927726707545120333437366077664140615939201750770877737347931743585549160358023127923093125498066385337643707069430158300378215495401599361103394545695002320568825172989798725205021193034879134568706562")
        m = BigUInt.init("1000")
        print("加密前: ", m)
        
        c = paillier.encrypt(m)
        
        print("加密后: ", c)
        
        print("解密后: ", paillier.decrypt(c))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

