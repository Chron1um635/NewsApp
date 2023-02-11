//
//  ViewControllerS.swift
//  NewsApp
//
//  Created by Максим Назаров on 05.02.2023.
//

import UIKit

class ViewControllerS: UIViewController {
    
    var viewModels = Article(source: .init(name: ""), title: "", description: "", autrhor: "", url: "", urlToImage: "", publishedAt: "")

    let newsTitleLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    let newsDescription: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.font = .systemFont(ofSize: 14, weight: .regular)
        return description
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let newsPublishDate: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.numberOfLines = 0
        date.font = .systemFont(ofSize: 12, weight: .regular)
        return date
    }()
    
    let newsAuthor: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.numberOfLines = 0
        author.font = .systemFont(ofSize: 12, weight: .regular)
        return author
    }()
    
    let newsURL: UILabel = {
        let url = UILabel()
        url.translatesAutoresizingMaskIntoConstraints = false
        url.isUserInteractionEnabled = true
        url.numberOfLines = 0
        url.font = .systemFont(ofSize: 12, weight: .regular)
        return url
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        view.backgroundColor = .systemBackground
        view.addSubview(newsTitleLabel)
        view.addSubview(newsDescription)
        view.addSubview(newsImage)
        view.addSubview(newsPublishDate)
        view.addSubview(newsAuthor)
        view.addSubview(newsURL)
        
        configure()
        newsImageConstraint()
        newsTitleConstraint()
        newsDesctiptionConstraint()
        newsURLConstraint()
        newsPublishingDateConstraint()
        newsAuthorConstraint()
        
    }
    
    func newsImageConstraint() {
        newsImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        newsImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        newsImage.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -200).isActive = true
    }
    
    func newsTitleConstraint() {
        newsTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 30).isActive = true
        newsTitleLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func newsDesctiptionConstraint() {
        newsDescription.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 20).isActive = true
        newsDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsDescription.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        newsDescription.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func newsURLConstraint() {
        newsURL.topAnchor.constraint(equalTo: newsAuthor.bottomAnchor,constant: 20).isActive = true
        newsURL.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        newsURL.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        newsURL.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func newsPublishingDateConstraint() {
        newsPublishDate.topAnchor.constraint(equalTo: newsDescription.bottomAnchor,constant: 20).isActive = true
        newsPublishDate.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
    }
    
    func newsAuthorConstraint() {
        newsAuthor.topAnchor.constraint(equalTo: newsPublishDate.bottomAnchor,constant: 10).isActive = true
        newsAuthor.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
    }
    
    func configure() {
        newsTitleLabel.text = viewModels.title
        newsDescription.text = viewModels.description
        newsPublishDate.text = viewModels.publishedAt
        newsAuthor.text = viewModels.autrhor
        newsURL.text = viewModels.url
        
        if let data = viewModels.imageData {
            newsImage.image = UIImage(data: data)
        }
        else if let urlString = viewModels.urlToImage, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                self?.viewModels.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    
    }

}
