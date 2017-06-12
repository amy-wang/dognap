//
//  SegueLeftToRight.swift
//  DogNapAlarm
//
//  Created by Yucen Zhang on 2017-06-11.
//  Copyright © 2017 Rain Pillar. All rights reserved.
//

import UIKit

class SegueToRight: UIStoryboardSegue {
    
    override func perform()
    {
    
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveEaseInOut,
                                   animations: {
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                                   completion: { finished in
                                    src.present(dst, animated: false, completion: nil)
        }
            
        )
    }
}
    

