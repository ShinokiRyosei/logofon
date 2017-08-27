//
//  RankingViewController.swift
//  logoFontGame
//
//  Created by Eriri Matsui on 2017/08/21.
//  Copyright © 2017年 Eriri Matsui. All rights reserved.
//

class Record {
    
    let username: String
    let score: Int
    
    init(username: String, score: Int) {
        self.username = username
        self.score = score
    }
    
}



import UIKit
import FirebaseDatabase


class RankingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    @IBOutlet var backButton: UIButton!
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
  
    var rankingArray: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewのデータソースメソッドをRankingViewControllerの中に書く
        table.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: "RankingCell")
        table.dataSource = self
        // Do any additional setup after loading the view.
        
        // データベースのrankingへ参照
        let ref = Database.database().reference().child("ranking")
        // そこからデータを取得
        ref.queryOrdered(byChild: "score").observe(DataEventType.value, with: { snapshot in
            guard let data = snapshot.value as? [String : AnyObject] else { return print(snapshot.value) }
            // socore, usernameのセット(辞書型)の配列
            let datas = data.map { $0.value as! [String: AnyObject] }
            
            for data in datas {
                if let score = data["score"] as? Int {
                    let record = Record(username: data["username"] as! String, score: score)
                    self.rankingArray.append(record)
                }
               
            }
            
            // score順に並び替え
            self.rankingArray.sort(by: {$0.score < $1.score})
            self.table.reloadData()
        })
        
    }

    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingArray.count
    }
    
    // cellにデータを入れて設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingCell") as! RankingCell
        cell.nameLabel.text = rankingArray[indexPath.row].username
        cell.scoreLabel.text = String((100 - rankingArray[indexPath.row].score) * 10)
        cell.rankLabel.text = String(indexPath.row + 1)

        return cell
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
