//
//  ViewController.swift
//  CatchTheBoyIfYouCan
//
//  Created by Yavuz Güner on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //views
    @IBOutlet weak var maggie9: UIImageView!
    @IBOutlet weak var maggie8: UIImageView!
    @IBOutlet weak var maggie7: UIImageView!
    @IBOutlet weak var maggie6: UIImageView!
    @IBOutlet weak var maggie5: UIImageView!
    @IBOutlet weak var maggie4: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var maggie1: UIImageView!
    @IBOutlet weak var maggie2: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var maggie3: UIImageView!
    
    //Variables
    var score = 0
    
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var highScore = 0
    
    //Kenny Hareket etmesi için önce bir array oluştururz.
    var maggieArray = [UIImageView] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score \(score)"
        
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        
        //Images
        maggie1.isUserInteractionEnabled = true //üzerine tıklandığı zaman etkin hale getirir.
        maggie2.isUserInteractionEnabled = true
        maggie3.isUserInteractionEnabled = true
        maggie4.isUserInteractionEnabled = true
        maggie5.isUserInteractionEnabled = true
        maggie6.isUserInteractionEnabled = true
        maggie7.isUserInteractionEnabled = true
        maggie8.isUserInteractionEnabled = true
        maggie9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        maggie1.addGestureRecognizer(recognizer1)
        maggie2.addGestureRecognizer(recognizer2)
        maggie3.addGestureRecognizer(recognizer3)
        maggie4.addGestureRecognizer(recognizer4)
        maggie5.addGestureRecognizer(recognizer5)
        maggie6.addGestureRecognizer(recognizer6)
        maggie7.addGestureRecognizer(recognizer7)
        maggie8.addGestureRecognizer(recognizer8)
        maggie9.addGestureRecognizer(recognizer9)
        
        //Maggie hareket etmesi için
        maggieArray = [maggie1,maggie2,maggie3,maggie4,maggie5,maggie6,maggie7,maggie8,maggie9]
        

        
        //timers
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideMaggie), userInfo: nil, repeats: true)
        
        
        
        hideMaggie()
        
    }

    @objc func hideMaggie() {
        for maggieArray in maggieArray {
            maggieArray.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(maggieArray.count - 1)))
        maggieArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score :\(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for maggieArray in maggieArray {
                maggieArray.isHidden = true
            } //Zaman bitince maggie'leri görünmez hale getiririz.
            
            //HIGHSCORE
            
            //Highscore'ı en sonda yapıyoruz.
            //Zaman bitince skora bak ve highscore ile karşılaştır. Veritabanı basit olarak kullanıcaz. Bu app'i kapasakta daha sonradan tekrar açacak olursak bunu yapacağız.
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            //Alert yazıyoruz. Zamanın bitti diye.
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                //Replay için yazdıklarımız.
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                //yukarıdakinin aynısını kopyalarız.
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMaggie), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

