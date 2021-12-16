//
//  UITextField+Extension.swift
//  AppModular
//
//  Created by Nicolas Ferrero on 14/12/2021.
//

import UIKit
public extension UITextField{
    func errorAnimated(){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = 4
        animation.duration = 0.4 / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [10,-10]
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
        self.layer.add(animation, forKey: "shake")
    }
    
    func sacarError(){
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0
    }
    
    func startInController() {
       self.alpha = 0
       UIView.animate(withDuration: 1, delay: 0.2, animations: {
           self.alpha = 1
       })
   }
}
