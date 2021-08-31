//
//  NewsTableViewCell.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/29/21.
//

import UIKit
import Kingfisher


class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateOfPublishLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfgiureCell(data:Article) {
        titleLabel.text = data.title ?? ""
        dateOfPublishLabel.text = data.publishedAt ?? ""
        let url = URL(string: data.urlToImage ?? "")
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url )
    }
}
