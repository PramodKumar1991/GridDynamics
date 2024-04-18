//
//  HomeViewController.swift
//  GridDynamicsTask
//
//  Created by Apalya on 18/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var newsTableView: UITableView!
    private var newsFeedListItems: [NewsFeedModel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(HomeViewCell.nib(), forCellReuseIdentifier: HomeViewCell.identifier)
        getArticles()
    }
    private func getArticles() {
        NewsFeedServicible().getAllArticles { result in
            switch result {
            case .success(let success):
                if let articles = success.articles, let items = articles.results {
                    self.newsFeedListItems = items
                    DispatchQueue.main.async {
                        self.newsTableView.reloadData()
                    }
                }
            case .failure(let failure):
                debugPrint(failure)
                break
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let feeds = newsFeedListItems, feeds.count > 0 else {return 0}
        return feeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier) as? HomeViewCell else {return UITableViewCell()}
        cell.configuare(news: newsFeedListItems[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsController") as! NewsDetailsController
        details.configuare(model: newsFeedListItems[indexPath.row])
        self.present(details, animated: true)
    }
}
