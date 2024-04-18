//
//  NewsDetailsController.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import UIKit

class NewsDetailsController: UIViewController {
    @IBOutlet private weak var newsTableView: UITableView!
    private var feed: NewsFeedModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(FeedImageCell.nib(), forCellReuseIdentifier: FeedImageCell.identifier)
    }
    func configuare(model: NewsFeedModel) {
        self.feed = model
    }
}
extension NewsDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard feed != nil else {return 0}
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedImageCell.identifier) as? FeedImageCell else {return UITableViewCell()}
        cell.configuare(news: feed)
        return cell
    }
}

