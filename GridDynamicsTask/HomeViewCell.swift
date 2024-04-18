//
//  HomeViewCell.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import UIKit
import Kingfisher

class HomeViewCell: UITableViewCell {
    @IBOutlet private weak var feedImageView: UIImageView!
    @IBOutlet private weak var feedTitleLabel: UILabel!
    static let identifier = "HomeViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "HomeViewCell", bundle: nil)
    }
    func configuare(news: NewsFeedModel) {
        if let title = news.title, !title.isEmpty {
            self.feedTitleLabel.text = title
        }
        if let image = news.image, !image.isEmpty, let url = URL(string: image) {
            self.feedImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder.webp"))
        }
    }
}
