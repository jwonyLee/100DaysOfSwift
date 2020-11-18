//
//  ViewController.swift
//  Project2
//
//  Created by 이지원 on 2020/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var gameCount = 0

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(scoreTapped))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        
        // *: 타이틀에 correctAnswer와 플레이어 점수 표시
        title = "\(countries[correctAnswer].uppercased()), now score: \(score)"
        gameCount += 1
    }
    
    // *: 잘못된 국가를 선택하면 경고 메세지에 정답 알려주기
    @IBAction func buttonTapped(_ sender: Any) {
        var title: String
        var message: String
        
        if let sender = sender as? UIButton, sender.tag == correctAnswer {
            title = "Correct"
            message = "Your score is \(score)."
            score += 1
        } else {
            title = "Wrong"
            message = "Wrong! That's the flag of \(countries[correctAnswer]), Your score is \(score)."
            score -= 1
        }
        
        // *: 10번의 게임 진행 후, 최종 결과 알려주기
        if self.gameCount == 10 {
            let alert = UIAlertController(title: "Final score", message: "Your score is \(self.score).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alert, animated: true)
        }
    }
    
    // *: Project 3 Challenge
    @objc func scoreTapped() {
        let alert = UIAlertController(title: "Score", message: "Your score is \(self.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

