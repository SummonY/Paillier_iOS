//
//  Paillier.swift
//  MSUD
//
//  Created by Summon Yang on 16/5/13.
//  Copyright © 2016年 Summon. All rights reserved.
//

import UIKit

import UIKit
import BigInt

class Paillier {
    
    var p: BigUInt!
    var q: BigUInt!
    var N: BigUInt!
    var N2: BigUInt!
    var lambda: BigUInt!
    var g: BigUInt!
    
    var E1: Double!
    var E2: Double!
    var M1: Double!
    var M2: Double!
    
    // 生成素数
    func generatePrime(width: Int) -> BigUInt {
        while true {
            var random = BigUInt.randomIntegerWithExactWidth(width)
            random |= BigUInt(1)
            if random.isPrime() {
                return random
            }
        }
    }
    
    // 最小公倍数
    func LCM(p: BigUInt, q: BigUInt) -> BigUInt! {
        var gcd: BigUInt!
        var mul: BigUInt!
        
        mul = p.multiply(q)
        gcd = BigUInt.gcd(p, q)
        
        return mul.multiply(gcd.inverse(N)!)
    }
    
    // 密钥生成
    func kenGen() {
        p = generatePrime(512)      // 大素数p
        q = generatePrime(512)      // 大素数q
        
        N = p.multiply(q)                  // N取1024位

        N2 = N.multiply(N)
        
        print("N = ", N)
        print("p = ", p)
        print("q = ", q)
        
        // 用户私钥
        lambda = LCM(p.subtract(BigUInt(1)), q: q.subtract(BigUInt(1)))
        
        print("lambda = ", lambda)
        
//        var iter: Bool = true
//        var L: BigUInt!
//        let One: BigUInt = 1
//        
//        while iter {
//            g = BigUInt.randomIntegerWithExactWidth(2048)
//            L = (g.power(lambda, modulus: N2).subtract(One)).divide(N).div
//            if (BigUInt.gcd(L, N) == One) {
//                iter = false
//            }
//        }
        
        g = BigUInt.init("2")
        
        print("g = ", g)
    }
    
    // 加密
    func encrypt(let m: BigUInt) -> BigUInt {
        var r: BigUInt!
        var gm: BigUInt!
        var rN: BigUInt!
        var c: BigUInt!
        
        r = BigUInt.randomIntegerWithExactWidth(1024)
        
        
        let startTimeE2 = CACurrentMediaTime()
        

        gm = g.power(m, modulus: N2)                 // E2 2048

        
        let timeElapsedE2 = CACurrentMediaTime() - startTimeE2
        E2 = timeElapsedE2
        print("E2 time : ", timeElapsedE2)
        
        
        
        let startTimeE1 = CACurrentMediaTime()
        
        rN = r.power(N, modulus: N2)                    // E1 1024
        
        let timeElapsedE1 = CACurrentMediaTime() - startTimeE1
        E1 = timeElapsedE1
        print("E1 time : ", timeElapsedE1)
        
        
        let startTimeM2 = CACurrentMediaTime()
        
        c = gm * rN % N2                            // M2 2048
        
        
        let timeElapsedM2 = CACurrentMediaTime() - startTimeM2
        M2 = timeElapsedM2
        print("M2 time : ", timeElapsedM2)
        
        
        return c
    }
    
    
    // 解密
    func decrypt(c: BigUInt) -> BigUInt {
        var plain: BigUInt!
        
        var lclambda = c.power(lambda, modulus: N2)
        lclambda = lclambda.subtract(1)
        lclambda = lclambda.divide(N).div
        lclambda = lclambda % N
        
        var lglambda = g.power(lambda, modulus: N2)
        lglambda = lglambda.subtract(1)
        lglambda = lglambda.divide(N).div
        lglambda = lglambda % N
        
        let startTimeM1 = CACurrentMediaTime()
        
        plain = lclambda.multiply(lglambda.inverse(N)!) % N
        
        let timeElapsedM1 = CACurrentMediaTime() - startTimeM1
        M1 = timeElapsedM1
        print("M1 time : ", timeElapsedM1)
        
        
        return plain
    }
    
    
}
