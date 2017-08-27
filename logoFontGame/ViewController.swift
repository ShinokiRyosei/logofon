//
//  ViewController.swift
//  logoFontGame
//
//  Created by Eriri Matsui on 2017/08/18.
//  Copyright © 2017年 Eriri Matsui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var quizArray = [[Any]]()
    var correctAnswer: Int = 0
    var count: Int = 0
    var timer: Timer = Timer()
    var isGameOver = true
    var segueTimer: Timer = Timer()
//    var choiceNumber: Int = 0

    
    @IBOutlet var quizLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    @IBOutlet var choiceButton4: UIButton!
    @IBOutlet var choiceLabel1: UILabel!
    @IBOutlet var choiceLabel2: UILabel!
    @IBOutlet var choiceLabel3: UILabel!
    @IBOutlet var choiceLabel4: UILabel!
    @IBOutlet var answerLabel1: UILabel!
    @IBOutlet var answerLabel2: UILabel!
    @IBOutlet var answerLabel3: UILabel!
    @IBOutlet var answerLabel4: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel1.isHidden = true
        answerLabel2.isHidden = true
        answerLabel3.isHidden = true
        answerLabel4.isHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //一時的にクイズを収納しておく配列
        var tmpArray = [[Any]]()
        var shuffledTmpArray: [[Any]] = []
        
        tmpArray.append(["NIKE","N","NikeBureau","NIKE","Varsity","LOWSON","TSBlock-Bold","IKEA","UbuntuTitling-Bold","LINE",1])
        tmpArray.append(["LOWSON","L","Canon","Canon","Varsity","LOWSON","TSBlock-Bold","IKEA","Walt Disney Script v4.1","Disney",2])
        tmpArray.append(["COCACOLA","C","CocaColaii","CocaCola","Walt Disney Script v4.1","Disney","Canon","Canon","UbuntuTitling-Bold","LINE",1])
        tmpArray.append(["DISNEY","D","Canon","Canon","Walt Disney Script v4.1","Disney","Billabong","Instagram","Lobster 1.4","Chupa Chups",2])
        tmpArray.append(["CANON","C","Canon","Canon","UbuntuTitling-Bold","LINE","Lobster 1.4","Chupa Chups","Walt Disney Script v4.1","Disney",1])
        tmpArray.append(["LINE","L","NikeBureau","NIKE","Lobster 1.4","Chupa Chups","TSBlock-Bold","IKEA","UbuntuTitling-Bold","LINE",4])
        tmpArray.append(["CHUPA CHUPS","C","Legothick","LEGO","Walt Disney Script v4.1","Disney","Lobster 1.4","Chupa Chups","Helvetica","TOYOTA",3])
        tmpArray.append(["IKEA","I","Walt Disney Script v4.1","Disney","TSBlock-Bold","IKEA","Helvetica","TOYOTA","AlternateGothicNo2BT-Regular","YouTube",2])
        tmpArray.append(["LEGO","L","Legothick","LEGO","Helvetica","TOYOTA","AlternateGothicNo2BT-Regular","YouTube","Billabong","Instagram",1])
        tmpArray.append(["TOYOTA","T","NikeBureau","NIKE","AlternateGothicNo2BT-Regular","YouTube","Billabong","Instagram","Helvetica","TOYOTA",4])
        tmpArray.append(["YOUTUBE","Y","NikeBureau","NIKE","UbuntuTitling-Bold","LINE","AlternateGothicNo2BT-Regular","YouTube","Walt Disney Script v4.1","Disney",3])
        tmpArray.append(["INSTAGRAM","I","NikeBureau","NIKE","Billabong","Instagram","Varsity","LOWSON","Coca Cola ii","CocaCola",2])
        
        
        
        //問題をシャッフルしてquizArrayに格納する
        while(tmpArray.count > 0) {
            let index = Int(arc4random()) % tmpArray.count
            shuffledTmpArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }

        for item in shuffledTmpArray {

            var tmpFontItem: [Any] = [item[2], item[4], item[6], item[8]] //
            var tmpAnswerItem: [Any] = [item[3], item[5], item[7], item[9]]
            var shuffledQuestionAray: [Any] = []
            var answerNumber: Int = 0
            var tmpElement: [Any] = [item[0]]

            while tmpFontItem.count > 0 {

                let index: Int = Int(arc4random_uniform(UInt32(tmpFontItem.count)))
                shuffledQuestionAray.append(tmpFontItem[index])
                shuffledQuestionAray.append(tmpAnswerItem[index])

                if item[10] as! Int == index {

                    answerNumber = index
                }

                tmpFontItem.remove(at: index)
                tmpAnswerItem.remove(at: index)
            }

            tmpElement = tmpElement + shuffledQuestionAray
            tmpElement.append(answerNumber)

            quizArray.append(tmpElement)
        }




        choiceQuiz()
        
        if !timer.isValid{
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(self.up),
                userInfo: nil,
                repeats: true
            )
        }
        
    }
    
    
    func choiceQuiz() {
        //一時的にクイズを取り出す配列
        let tmpArray = quizArray[0]
        
        quizLabel.text = tmpArray[0] as? String
        choiceLabel1.text = tmpArray[1] as? String
        choiceLabel1.font = UIFont(name: tmpArray[2] as! String, size: 60)
        choiceLabel2.text = tmpArray[1] as? String
        choiceLabel2.font = UIFont(name: tmpArray[4] as! String, size: 60)
        choiceLabel3.text = tmpArray[1] as? String
        choiceLabel3.font = UIFont(name: tmpArray[6] as! String, size: 60)
        choiceLabel4.text = tmpArray[1] as? String
        choiceLabel4.font = UIFont(name: tmpArray[8] as! String, size: 60)
        
        answerLabel1.text = ""
        answerLabel2.text = ""
        answerLabel3.text = ""
        answerLabel4.text = ""
    }
    
    
    @IBAction func choiceAnswer(sender: UIButton) {
//        choiceNumber = Int(arc4random_uniform(4))
        answerLabel1.isHidden = false
        answerLabel2.isHidden = false
        answerLabel3.isHidden = false
        answerLabel4.isHidden = false
        
        if answerLabel.text != "" { return }
        let tmpArray = quizArray[0]
        if tmpArray[10] as! Int == sender.tag {
            correctAnswer = correctAnswer + 1
            answerLabel.textColor = UIColor.red
            answerLabel.text = "TRUE"
        }else {
            segueTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeView), userInfo: nil, repeats: false)
            isGameOver = true
            answerLabel.textColor = UIColor.blue
            answerLabel.text = "FALSE"
        }
        answerLabel1.text = tmpArray[3] as? String
        answerLabel2.text = tmpArray[5] as? String
        answerLabel3.text = tmpArray[7] as? String
        answerLabel4.text = tmpArray[9] as? String
        
        quizArray.remove(at: 0)
    }
    
    func changeView() {
        performSegue(withIdentifier: "toFinalView", sender: nil)
    }
    
    @IBAction func next() {
        answerLabel.text = ""
        if quizArray.count == 0 {
            performSegueToResult()
            if timer.isValid {
                timer.invalidate()
            }
        }else {
            choiceQuiz()
        }
        
    }
    
    func up() {
        count = count + 1
        //        timeLabel.text = String(count)
    }
    
    func performSegueToResult() {
        isGameOver = false
        performSegue(withIdentifier: "toFinalView", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinalView" {
            let finalViewController = segue.destination as! FinalViewController
            //            finalViewController.time = Int(self.timeLabel.text!)!
            finalViewController.correctAnswer = self.correctAnswer
            finalViewController.isGameOver = self.isGameOver
            finalViewController.time = self.count
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

