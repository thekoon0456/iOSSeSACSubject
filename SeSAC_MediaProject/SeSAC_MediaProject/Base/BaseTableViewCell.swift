//
//  BaseTableViewCell.swift
//  SeSAC_MediaProject
//
//  Created by Deokhun KIM on 1/31/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return self.description()
     }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureCell()
    }

    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }
    func configureCell() { }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
