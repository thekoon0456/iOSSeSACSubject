//
//  MagazinInfoCell.swift
//  SeSAC_MakeTableViewController
//
//  Created by Deokhun KIM on 1/8/24.
//

import UIKit

import Kingfisher

class MagazinInfoCell: UITableViewCell {
    
    static let cellID = "MagazinInfoCell"
    
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureImage()
        configureLabel()
    }
    
    func setDate(_ input: String){
        let formatter = DateFormatter()
        let inputStringDate = formatter.date(from: input)
        formatter.dateFormat = "yy년 M월 d일"
        let result = formatter.string(from: inputStringDate ?? Date())
        dateLabel.text = result
    }
    
    func setValue(_ input: Magazine) {
        let placeHolderImage = UIImage(named: "loadingImage")
        
        cellImageView.kf.setImage(with: URL(string: input.photo_image),
                                  placeholder: placeHolderImage)
        titleLabel.text = input.title
        subTitleLabel.text = input.subtitle
        setDate(input.date)
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
