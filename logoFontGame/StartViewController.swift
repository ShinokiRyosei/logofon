//
//  StartViewController.swift
//  LOGOFON
//
//  Created by Eriri Matsui on 2017/08/26.
//  Copyright © 2017年 Eriri Matsui. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var segueTimer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        segueTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeView), userInfo: nil, repeats: false)
        
    }
    
    func changeView() {
        performSegue(withIdentifier: "toFV", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
