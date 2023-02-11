//
//  ViewController.swift
//  NewsApp
//
//  Created by Максим Назаров on 05.02.2023.
//

import UIKit
import SafariServices


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private var viewModels = [NewsTableViewCellModel]()
    private var articles = [Article]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        
        title = "News"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        tableView.addSubview(refreshControl)
        dataReady()
    }
    @objc func refresh(_ sender: Any) {
        dataReady()
    }
    func dataReady() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellModel(
                        title: $0.title,
                        count: $0.description ?? "No description",
                        imageURL: $0.urlToImage
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        let data = Article(source: article.source, title: article.title, description: article.description, autrhor: article.autrhor, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt)
        
        let newsDetailViewController = ViewControllerS()
        newsDetailViewController.viewModels = data
        
        navigationController?.pushViewController(newsDetailViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

