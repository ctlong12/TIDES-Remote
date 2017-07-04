//
//  AnimatePopUp.swift
//  TidesInventory
//
//  Created by Chandler Long on 5/20/17.
//  Copyright © 2017 Chandler Long. All rights reserved.
//

import Foundation
import UIKit

class Animations {
    
    static func animatePopUpIn(view: UIView, controller: UIViewController) {
        
        controller.view.addSubview(view)
        view.center = CGPoint(x: controller.view.frame.width / 2, y: 175)
        
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            view.alpha = 1
            view.transform = CGAffineTransform.identity
        }
        
    }
    
    static func animatePopUpOut(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            view.alpha = 0
            
        }) { (success:Bool) in
            view.removeFromSuperview()
            
        }
        
    }
    
}
