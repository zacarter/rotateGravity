//
//  ViewController.swift
//  testMotion
//
//  Created by Zachary on 5/6/15.
//  Copyright (c) 2015 test. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var myMotionHandler: CMMotionManager?
    var motionLastYaw: Double = 0
    var timer: NSTimer?
    var a: CMAcceleration?
    var v: CGPoint?
    
    @IBOutlet var ball: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myMotionHandler = CMMotionManager()
        //myMotionHandler?.startAccelerometerUpdates()
        self.ball.layer.cornerRadius = 25;
        
        myMotionHandler?.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: {(adata: CMAccelerometerData!, error: NSError!) in
            //println("\(adata.acceleration.x) \(adata.acceleration.y) \(adata.acceleration.z)")
            self.a = adata.acceleration
            if (error != nil)
            {
                print("\(error)")
            }
        })
        self.v = CGPointMake(0,0);
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.033, target: self, selector: Selector("animate"), userInfo: nil, repeats: true)
        //self.timer = NSTimer(timeInterval: 0.033, target: self, selector: Selector("animate"), userInfo: nil, repeats: true)
        
        
    }
    
    func animate() {
        if let a = self.a
        {
            self.v = CGPointMake(self.v!.x+CGFloat(a.x*0.2), self.v!.y+CGFloat(a.y*0.2))
            
            
            var newXform = CGAffineTransformTranslate(self.ball.transform, CGFloat(self.v!.x), CGFloat(-self.v!.y))
            
            if (newXform.tx < -150 || newXform.tx > (self.view.bounds.size.width/2-self.ball.frame.size.width)){
                newXform.tx = self.ball.transform.tx
                self.v!.x = 0
            }
            if (newXform.ty < -200 || newXform.ty > (self.view.bounds.size.height/2-self.ball.frame.size.width)){
                newXform.ty = self.ball.transform.ty
                self.v!.y = 0
            }
            
            self.ball.transform = newXform
            //println("\(newXform.tx) \(newXform.ty)")
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

