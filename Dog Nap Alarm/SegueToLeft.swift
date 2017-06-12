//
//  SegueToLeft.swift
//  DogNapAlarm
//
//  Created by Yucen Zhang on 2017-06-11.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class SegueToLeft: UIStoryboardSegue {
    override func perform()
    {
        
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        src.navigationController?.setNavigationBarHidden(true, animated: false)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.dismiss(animated: false, completion: nil)
        }
            
        )
    }
    
}


