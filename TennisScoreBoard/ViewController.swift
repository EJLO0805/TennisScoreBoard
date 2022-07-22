//
//  ViewController.swift
//  TennisScoreBoard
//
//  Created by 羅以捷 on 2022/7/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var pointScore:[Int] = [15, 15, 10, 1, 1]
    var pointScoreforIndex:[Int] = [0, 0]
    var realPointScore:[Int] = [0, 0]
    var winSet:[Int] = [0, 0]
    var getSet:[Int] = [0, 0]
    var getSetIndex:[Int] = [2,2]
    //顯示結果
    func showPointResult() {
        PlayerAScore[getSetIndex[0]].text = "\(getSet[0])"
        PlayerBScore[getSetIndex[1]].text = "\(getSet[1])"
        PlayerAScore[0].text = "\(realPointScore[0])"
        PlayerBScore[0].text = "\(realPointScore[1])"
    }
    //贏得最終比賽
    func winTheGame(){
        if winSet[0] == 3 {
            showResult.text = "Player A 獲勝，請按Restart重新開始"
        } else if winSet[1] == 3 {
            showResult.text = "Player B 獲勝，請按Restart重新開始"
        }
    }
    // 得分
    func addPoint (number: Int) {
        realPointScore[number] = realPointScore[number] + pointScore[pointScoreforIndex[number]]
        if number == 0 {
            pointScoreforIndex[0] = pointScoreforIndex[0] + 1
        } else if number == 1 {
            pointScoreforIndex[1] = pointScoreforIndex[1] + 1
        }
        if pointScoreforIndex[0] > 2, pointScoreforIndex[1] > 2 {
            pointDeuce(number: number)
        } else if pointScoreforIndex[0] == 4 || pointScoreforIndex[1] == 4 {
            pointScoreforIndex = [0,0]
            realPointScore = [0,0]
            getSet[number] = getSet[number] + 1
            showPointResult()
        } else {
            showPointResult()
        }
    }
    // pointDeuce
    func pointDeuce(number : Int){
        let numberforDuece = pointScoreforIndex[0] - pointScoreforIndex[1]
        if numberforDuece == 0 {
            pointScoreforIndex = [3, 3]
            realPointScore = [40, 40]
            showPointResult()
        } else if  numberforDuece == 2 || numberforDuece == -2 {
            pointScoreforIndex = [0,0]
            realPointScore = [0,0]
            getSet[number] = getSet[number] + 1
            showPointResult()
        } else if numberforDuece == 1 {
            PlayerAScore[0].text = "AD"
            PlayerBScore[0].text = ""
        } else if numberforDuece == -1 {
            PlayerAScore[0].text = ""
            PlayerBScore[0].text = "AD"
        }
    }
    // 取得五盤的方式
    func getfiveSet(number: Int) {
        for i in 0...1 {
            getSetIndex[i] = getSetIndex[i] + 1
        }
        getSet = [0, 0]
        winSet[number] = winSet[number] + 1
        PlayerAScore[1].text = "\(winSet[0])"
        PlayerBScore[1].text = "\(winSet[1])"
        winTheGame()
    }
    
    
    
    @IBOutlet var PlayerAScore: [UILabel]!
    @IBOutlet var PlayerBScore: [UILabel]!
    @IBOutlet weak var showResult: UILabel!
    @IBAction func playerAGetPoint(_ sender: Any) {
        if winSet[0] == 3 || winSet[1] == 3 {
            winTheGame()
        } else if getSet[0] > 4, getSet[1] > 4 {
            addPoint(number: 0)
            if getSetIndex[0] == 6 {
                let setPoint = getSet[0] - getSet[1]
                if setPoint == 2 || setPoint == -2 {
                    getfiveSet(number: 0)
                }
            } else if getSet[0] == 7 {
                getfiveSet(number: 0)
            }
        } else {
            addPoint(number: 0)
            if getSet[0] == 6 {
                getfiveSet(number: 0)
            }
        }
    }
    
    
    @IBAction func playerBGetPoint(_ sender: Any) {
        if winSet[0] == 3 || winSet[1] == 3 {
            winTheGame()
        } else if getSet[0] > 4, getSet[1] > 4 {
            addPoint(number: 1)
            if getSetIndex[1] == 6 {
                let setPoint = getSet[0] - getSet[1]
                if setPoint == 2 || setPoint == -2 {
                    getfiveSet(number: 1)
                }
            } else if getSet[1] == 7 {
                getfiveSet(number: 1)
            }
        } else {
            addPoint(number: 1)
            if getSet[1] == 6 {
                getfiveSet(number: 1)
            }
        }
    }
    //重新開始計算
    @IBAction func restart(_ sender: Any) {
        pointScoreforIndex = [0, 0]
        realPointScore = [0, 0]
        getSetIndex = [2, 2]
        winSet = [0, 0]
        getSet = [0, 0]
        for restartA in PlayerAScore {
            restartA.text = "0"
        }
        for restartB in PlayerBScore {
            restartB.text = "0"
        }
        showResult.text = "重新開始計分"
    }
    
}

