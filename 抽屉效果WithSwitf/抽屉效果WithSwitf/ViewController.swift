//
//  ViewController.swift
//  抽屉效果WithSwitf
//
//  Created by Suzh on 15/12/25.
//  Copyright © 2015年 Suzh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var redView = UIView(frame: UIScreen.mainScreen().bounds)
    var blueView = UIView(frame: UIScreen.mainScreen().bounds)
    var greenView = UIView(frame: UIScreen.mainScreen().bounds)
    
    func setupViews() {
        
        redView.backgroundColor = UIColor.redColor()
        blueView.backgroundColor = UIColor.blueColor()
        greenView.backgroundColor = UIColor.greenColor()
        
        view.addSubview(blueView)
        view.addSubview(greenView)
        view.addSubview(redView)
    }
    
    func setupGes() {
        let panGes = UIPanGestureRecognizer(target: self, action: "panGes:")
        let tapGes = UITapGestureRecognizer(target: self, action: "tapGes:")
        
        redView.addGestureRecognizer(panGes)
        redView.addGestureRecognizer(tapGes)
    }
    
    func tapGes(ges: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.redView.frame = UIScreen.mainScreen().bounds
        }
    }
    
    func panGes(ges: UIPanGestureRecognizer) {
        
        
        let translatePoint = ges.translationInView(redView)
        redView.frame = frameWithOffset(translatePoint.x)
        
        let gestureStatus = ges.state
        
        switch gestureStatus {
            //触发时机...?
        case .Possible: print("手势识别成功---")
        case .Began: print("手势开始")
        case .Ended: print("手势结束---")
        var target = 0;
        if redView.frame.origin.x > SSExtension().getMainScreenBouns().size.width * 0.3 {
            target = 300;
        } else if CGRectGetMaxX(redView.frame) < SSExtension().getMainScreenBouns().size.width * 0.7 {
            target = -300;
            }
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                let offset = CGFloat(target) - self.redView.frame.origin.x
                self.redView.frame = self.frameWithOffset(offset)
            })
            
        case .Changed: hideBackgroundViews()
            
        default:break
        }
        //复位
        ges.setTranslation(CGPoint.zero, inView: redView)
    }
    
    func hideBackgroundViews() {
        
        if redView.frame.origin.x > 0 {
            blueView.hidden = true
            greenView.hidden = false
        } else if redView.frame.origin.x < 0 {
            blueView.hidden = false
            greenView.hidden = true
        }
    }
    
    func frameWithOffset(offset: CGFloat) -> CGRect {
        
        var tempFrame = redView.frame
        tempFrame.origin.x += offset
        tempFrame.origin.y = fabs(tempFrame.origin.x * 100 / SSExtension().getMainScreenBouns().size.width)
        tempFrame.size.height = SSExtension().getMainScreenBouns().size.height - 2 * tempFrame.origin.y
        
        return tempFrame
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        setupViews()
        setupGes()
        
        
        
    }
    
    


}

