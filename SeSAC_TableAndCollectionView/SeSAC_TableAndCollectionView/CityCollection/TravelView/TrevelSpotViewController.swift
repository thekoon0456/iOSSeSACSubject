//
//  TrevelSpotViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

class TrevelSpotViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    
    static let vcID = "TrevelSpotViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI() {
        navigationItem.title = "관광지 화면"
        
        titleLabel.text = "관광지 화면"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
