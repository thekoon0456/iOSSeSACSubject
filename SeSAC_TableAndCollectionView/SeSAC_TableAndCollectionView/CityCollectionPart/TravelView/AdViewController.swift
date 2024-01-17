//
//  AdViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

final class AdViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension AdViewController: SetUI {
    func configureUI() {
        navigationItem.title = Title.adScene
        titleLabel.text = Title.adScene
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
