//
//  NewsfeedCell.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import UIKit


class NewsfeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        backgroundColor = .white
        
    }
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    func configure(viewModel: FeedCellProtocol) {
        
        if let photo = viewModel.photoAttachment {
            postImageView.set(imageUrl: photo.photoUrlString)
        }
        
        iconImageView.set(imageUrl: viewModel.iconURLString)
        postGeneralLabel.text = viewModel.generalName
        dateLabel.text = viewModel.date
        postDescriptionLabel.text = viewModel.postDescription
        likeLabel.text = viewModel.likes
        commentLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postGeneralLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        containerView.frame = viewModel.sizes.bottomViewFrame
    }
    
    let iconImageView: CachedImageView = {
        let image = CachedImageView()
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let postGeneralLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let postImageView: CachedImageView = {
        let image = CachedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .green
        //image.contentMode = .scaleAspectFill
        return image
    }()
    
    let likeImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "like"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    let commentImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "comment"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    let shareImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "share"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let shareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    let viewsImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "eye"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    func setupCell() {
        
        addSubview(iconImageView)
        addSubview(postGeneralLabel)
        addSubview(dateLabel)
        addSubview(postDescriptionLabel)
        addSubview(postImageView)
        addSubview(likeImageView)
        addSubview(likeLabel)
        addSubview(commentImageView)
        addSubview(commentLabel)
        addSubview(shareImageView)
        addSubview(shareLabel)
        addSubview(viewsImageView)
        addSubview(viewsLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            postGeneralLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            postGeneralLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: postGeneralLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: postGeneralLabel.topAnchor, constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            postDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            postDescriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: -10),
        ])
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        let likeStackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel])
        likeStackView.spacing = 7
        
        let commentStackView = UIStackView(arrangedSubviews: [commentImageView, commentLabel])
        commentStackView.spacing = 7

        let shareStackView = UIStackView(arrangedSubviews: [shareImageView, shareLabel])
        shareStackView.spacing = 7

        let viewsStackView = UIStackView(arrangedSubviews: [viewsImageView, viewsLabel])
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        viewsStackView.spacing = 7
        
        let likeCommentSharesBottomStackView = UIStackView(arrangedSubviews: [likeStackView, commentStackView, shareStackView])
        likeCommentSharesBottomStackView.translatesAutoresizingMaskIntoConstraints = false
        likeCommentSharesBottomStackView.distribution = .fillEqually
        likeCommentSharesBottomStackView.spacing = 30
        
        containerView.addSubview(likeCommentSharesBottomStackView)
        containerView.addSubview(viewsStackView)

        NSLayoutConstraint.activate([
            likeCommentSharesBottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            likeCommentSharesBottomStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            likeCommentSharesBottomStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            postImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            viewsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            viewsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
