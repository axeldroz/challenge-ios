//
//  FeedViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit
import SDWebImage

final class FeedViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var viewModel: FeedViewModelProtocol
    
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(viewModel: FeedViewModelProtocol = FeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = FeedViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SDWebImageManager.shared.delegate = self
        view.backgroundColor = .systemRed
        configureUI()
        bindViewModel()
        fetchData()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureCollectionViewUI()
        configureCollectionView()
    }
    
    private func configureNavigationBar() {
        let logoutButton = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonPressed(_:)))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
//    private func configureTableView() {
//        tableView.register(ParentBankTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ParentBankTableViewHeader")
//        tableView.register(BankTableViewCell.self, forCellReuseIdentifier: "BankTableViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
    
    private func configureCollectionView() {
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ParentBankCollectionViewCell.self, forCellWithReuseIdentifier: "ParentBankCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
    }
    
    private func configureCollectionViewUI() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
    }
    
//    private func configureTableViewUI() {
//        view.addSubview(tableView)
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//    }
    
    @objc func buttonPressed(_ sender: Any?) {
        coordinator?.logout()
    }
    
    func fetchData() {
        viewModel.fetch()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            print("UPDATE !!!!!!")
            //self?.tableView.reloadData()
            self?.collectionView.reloadData()
        }
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.parentBanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.3, height: collectionView.frame.size.width / 1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParentBankCollectionViewCell", for: indexPath) as? ParentBankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = indexPath.row
        guard row < viewModel.parentBanks.count else { return UICollectionViewCell() }
        
        let vm = viewModel.parentBanks[row]
        cell.setData(viewModel: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.showSubBanks(subBanks: viewModel.banks[indexPath.item])
    }
}

extension FeedViewController: SDWebImageManagerDelegate {
    func imageManager(_ imageManager: SDWebImageManager, transformDownloadedImage image: UIImage?, with imageURL: URL?) -> UIImage? {
        guard let image = image else { return nil }
        return image.cropAlpha()
    }
}
