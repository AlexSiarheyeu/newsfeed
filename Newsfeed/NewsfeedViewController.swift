//
//  NewsfeedViewController.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayDataProtocol: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayDataProtocol {

    var interactor: NewsfeedFetchDataProtocol?
    var collectionView: UICollectionView!
    private var newsfeedViewModel = FeedViewModel(posts: [])
  
    
  // MARK: View Controller lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setup()
        interactor?.makeRequest(request: .newsfeed)
        
    }
    
    private func setup() {
    
        let viewController = self
        let interactor = NewsfeedInteractor()
        let presenter = NewsfeedPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
  }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsfeedCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    
    case .displayNewsfeed(let newsfeed):
        
        self.newsfeedViewModel = newsfeed
        self.collectionView.reloadData()
    }
  }
}


extension NewsfeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsfeedViewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NewsfeedCell
        let viewModel = newsfeedViewModel.posts[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeihgt = newsfeedViewModel.posts[indexPath.row].sizes.totalHeight
        return .init(width: collectionView.frame.width, height: cellHeihgt)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
