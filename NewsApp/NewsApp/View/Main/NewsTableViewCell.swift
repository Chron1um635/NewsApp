//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Максим Назаров on 05.02.2023.
//

import UIKit

class NewsTableViewCellModel {
    let title: String
    let count: String
    let imageURL: String?
    var imageData: Data? = nil
    
    init(title: String, count: String, imageURL: String?) {
        self.title = title
        self.count = count
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    var count: Int = 0 {
        didSet {
            viewsCount.text = "\(count)"
        }
    }
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let viewsCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let viewCountImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(systemName: "eye"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(viewsCount)
        contentView.addSubview(newsImageView)
        contentView.addSubview(viewCountImageView)
        
        newsImageViewConstraint()
        newsTitleLabelConstraint()
        viewCountConstraint()
        viewCountImageViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newsImageViewConstraint() {
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20).isActive = true
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20).isActive = true
        newsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -100).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func newsTitleLabelConstraint() {
        newsTitleLabel.leftAnchor.constraint(equalTo: newsImageView.rightAnchor, constant: 20).isActive = true
        newsTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        newsTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func viewCountConstraint() {
        viewsCount.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        viewsCount.topAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
        viewsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func viewCountImageViewConstraint() {
        viewCountImageView.rightAnchor.constraint(equalTo: viewsCount.leftAnchor,constant: -10).isActive = true
        viewCountImageView.topAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
        viewCountImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        viewsCount.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellModel) {
        newsTitleLabel.text = viewModel.title
        viewsCount.text = "0"
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let urlString = viewModel.imageURL, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
