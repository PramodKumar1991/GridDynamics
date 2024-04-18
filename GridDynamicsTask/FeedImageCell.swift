//
//  FeedImageCell.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import UIKit

class FeedImageCell: UITableViewCell {
    @IBOutlet private weak var feedImageView: UIImageView!
    @IBOutlet private weak var feedTitleLabel: UILabel!
    @IBOutlet private weak var feedDescLabel: UILabel!
    static let identifier = "FeedImageCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "FeedImageCell", bundle: nil)
    }
    func configuare(news: NewsFeedModel) {
        if let image = news.image, !image.isEmpty, let url = URL(string: image) {
            self.feedImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder.webp"))
        }
        if let title = news.title, !title.isEmpty {
            self.feedTitleLabel.text = title
        }
        if let body = news.body, !body.isEmpty {
            self.feedDescLabel.text = body
        }
    }
}
