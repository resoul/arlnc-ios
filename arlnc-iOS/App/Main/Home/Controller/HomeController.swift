//
//  HomeController.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class HomeController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            case 1:
                let height = self.view.frame.size.height - 150
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(height))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(height))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                
                return section
            default:
                return nil
            }
        }
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    private let logoText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.text = "arlnc"
        
        return label
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        let notificationImage = UIImage(named: "notification-light")?.withRenderingMode(.alwaysOriginal)
        let notificationBarBtn = UIBarButtonItem(image: notificationImage, style: .plain, target: self, action: #selector(console))
        let messageImage = UIImage(named: "chat-light")?.withRenderingMode(.alwaysOriginal)
        let messageBarBtn = UIBarButtonItem(image: messageImage, style: .plain, target: self, action: #selector(console))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: logoText)
        navigationItem.rightBarButtonItems = [messageBarBtn, notificationBarBtn]
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(cell: StoriesView.self)
        collectionView.register(cell: StoriesMeView.self)
        
        collectionView.constraints(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc
    func console() {
        print("tapped")
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fetchedData.count + 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withClass: StoriesMeView.self, for: indexPath)
                let stories = fetchedData[indexPath.row]
                let model = StoriesViewModel(user: stories.user, lastViewedIndex: stories.lastViewedIndex, stories: stories.stories)
                cell.configure(with: model)
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withClass: StoriesView.self, for: indexPath)
                let stories = fetchedData[indexPath.row - 1]
                let model = StoriesViewModel(user: stories.user, lastViewedIndex: stories.lastViewedIndex, stories: stories.stories)
                cell.configure(with: model)
                
                return cell
            }
        case 1:
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let addStory = UIAlertAction(title: "add story", style: .default) { _ in
                    print("add story")
                }
                let viewStory = UIAlertAction(title: "view story", style: .default) { _ in
                    print("view story")
                }
                let cancel = UIAlertAction(title: "cancel", style: .cancel) { _ in
                    print("cancel")
                }
                
                controller.addAction(addStory)
                controller.addAction(viewStory)
                controller.addAction(cancel)
                
                present(controller, animated: true)
            } else {
                let controller = StoriesPresenterController(stories: fetchedData[indexPath.row].stories)
                controller.modalPresentationStyle = .overFullScreen
                present(controller, animated: true)
            }
            break
        case 1:
            print("tapped")
            break
        default:
            break
        }
    }
}
