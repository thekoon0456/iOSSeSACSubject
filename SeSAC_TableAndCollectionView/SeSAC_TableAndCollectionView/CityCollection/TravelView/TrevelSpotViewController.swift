//
//  TrevelSpotViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

final class TrevelSpotViewController: UIViewController {
 
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension TrevelSpotViewController: setUI {
    func configureUI() {
        navigationItem.title = Title.trevelScene
        
        titleLabel.text = Title.trevelScene
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
