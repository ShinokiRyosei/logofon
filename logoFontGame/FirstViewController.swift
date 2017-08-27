//
//  FirstViewController.swift
//  logoFontGame
//
//  Created by Eriri Matsui on 2017/08/18.
//  Copyright © 2017年 Eriri Matsui. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    @IBAction func startButton(_ sender: AnyObject) {
           }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let image = UIImage.gif(name: "logofongif")
        gifImageView.image = image
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
