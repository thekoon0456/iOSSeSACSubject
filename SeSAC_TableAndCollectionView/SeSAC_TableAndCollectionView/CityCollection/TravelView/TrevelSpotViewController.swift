//
//  TrevelSpotViewController.swift
//  SeSAC_TableAndCollectionView
//
//  Created by Deokhun KIM on 1/11/24.
//

import UIKit

final class TrevelSpotViewController: UIViewController {

    
    @IBOutlet var titleLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    func configureUI() {
        navigationItem.title = Title.trevelScene
        
        titleLabel.text = Title.trevelScene
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
    }
}
