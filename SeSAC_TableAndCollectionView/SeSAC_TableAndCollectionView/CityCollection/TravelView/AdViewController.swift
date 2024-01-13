//
//  AdViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

class AdViewController: UIViewController {

    static let identifier = "AdViewController"
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI() {
        navigationItem.title = Title.adScene
        titleLabel.text = Title.adScene
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
