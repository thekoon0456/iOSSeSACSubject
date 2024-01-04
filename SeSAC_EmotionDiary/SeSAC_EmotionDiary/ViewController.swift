//
//  ViewController.swift
//  SeSAC_EmotionDiary
//
//  Created by Deokhun KIM on 1/2/24.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var images: [UIImageView]!
    
    @IBOutlet var names: [UILabel]!
    
    @IBOutlet var counts: [UILabel]!
    
    @IBOutlet var stackViews: [UIStackView]!
    
    let indexs: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    let titles = ["행복해", "사랑해", "좋아해", "당황해",
                  "속상해", "우울해", "심심해", "행복해", "행복해"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "감정 다이어리"

        indexs.forEach { i in
            //image, titleLabel 설정
            images[i].image = UIImage(named: "slime\(i + 1)")
            names[i].text = titles[i]
            
            //label 설정
            names[i].textAlignment = .center
            counts[i].textAlignment = .center
            
            //각 index를 UserDefaults 키로 불러옴
            let key = String(i)
            counts[i].text = String(UserDefaults.standard.integer(forKey: key))
        }
    }
    
    @IBAction func buttonTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { 
            print("tag 값이 없습니다.")
            return
        }
        
        buttonTapped(tag: tag)
    }
    
    func buttonTapped(tag: Int) {
        counts.forEach { label in
            //count label의 tag 찾아서 적용
            if label.tag == tag {
                var count = Int(label.text!) ?? 0
                count += 1
                
                //UserDefaults 저장
                UserDefaults.standard.set(count, forKey: "\(label.tag)")
                
                //label 화면 업데이트
                label.text = String(count)
            }
        }
    }
}

