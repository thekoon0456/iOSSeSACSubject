//
//  MagazinInfoCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import UIKit

import Kingfisher

final class MagazinInfoCell: UITableViewCell {
    
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
}

extension MagazinInfoCell: setUI {
    func configureUI() {
        configureImage()
        configureLabel()
    }
    
    func configureImage() {
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.layer.cornerRadius = 20
        cellImageView.clipsToBounds = true
    }
    
    func configureLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.textColor = .darkGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
    }
}

extension MagazinInfoCell: setCell {
    
    typealias T = Magazine
    
    func configureCellData(_ data: Magazine) {
        let placeHolderImage = UIImage(named: "loadingImage")
        
        cellImageView.kf.setImage(with: URL(string: data.photo_image),
                                  placeholder: placeHolderImage)
        titleLabel.text = data.title
        subTitleLabel.text = data.subtitle
        setDate(data.date)
    }
    
    func setDate(_ input: String){
        let formatter = DateFormatter()
        let inputStringDate = formatter.date(from: input)
        formatter.dateFormat = "yy년 M월 d일"
        let result = formatter.string(from: inputStringDate ?? Date())
        dateLabel.text = result
    }
}
