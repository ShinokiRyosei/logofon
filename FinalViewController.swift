//
//  FinalViewController.swift
//  logoFontGame
//
//  Created by Eriri Matsui on 2017/08/18.
//  Copyright © 2017年 Eriri Matsui. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Accounts

class FinalViewController: UIViewController {
    
    //正解数
    var correctAnswer: Int = 0
    var time: Int = 0
    var isGameOver = true
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var loserImageView: UIImageView!
    @IBOutlet var addImageView: UIImageView!
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var shareImageView: UIImageView!
    @IBOutlet var clearImageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var yourScoreLabel: UILabel!
    @IBOutlet var gifImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage.gif(name: "logofongif")
        gifImageView.image = image

        if isGameOver {
            loserImageView.isHidden = false
            clearImageView.isHidden = true
            addImageView.alpha = 0.5
            shareImageView.alpha = 0.5
            addButton.isEnabled = false
            shareButton.isEnabled = false
            yourScoreLabel.isHidden = true
            gifImageView.isHidden = true
        } else {
            loserImageView.isHidden = true
            clearImageView.isHidden = false
            addImageView.alpha = 1
            shareImageView.alpha = 1
            addButton.isEnabled = true
            shareButton.isEnabled = true
            yourScoreLabel.isHidden = false
            gifImageView.isHidden = false

        }
        
    }
    
    private func getScreenShot() -> UIImage {
        let rect = self.view.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.view.layer.render(in: context)
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isGameOver {
        } else {
            timerLabel.text = String((100 - time) * 10)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rank() {
        showTextInputAlert()
        
    }
    @IBAction func back() {
        self.presentingViewController?.presentingViewController?
            .dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ranking() {
        
    }
    
    @IBAction func share(sender: UIImageView) {
        
        // 共有する項目
        let shareNameText = "Score\(timerLabel.text!)on LOGOFON!"
//        let shareScoreText = timerLabel.text!
        
        let shareWebsite = NSURL(string: "")!
        let shareImage = getScreenShot()
        let activityItems: [Any] = [shareNameText, shareWebsite, shareImage]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func showTextInputAlert() {
        // テキストフィールド付きアラート表示
        
        let alert = UIAlertController(title: "プレイヤー名", message: "", preferredStyle: .alert)
        
        // OKボタンの設定
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    print(textField.text!)
                    // データベースへの参照
                    let database = Database.database().reference()
                    database.child("ranking").childByAutoId().setValue(["username": textField.text!, "score": self.time])
                    
                }
            }
        })
        alert.addAction(okAction)
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
        })
        
        alert.view.setNeedsLayout()
        
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
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
