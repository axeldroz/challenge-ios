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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        view.backgroundColor = .systemRed
        configureUI()
        bindViewModel()
        fetchData()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureTableViewUI()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        let logoutButton = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonPressed(_:)))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func configureTableView() {
        tableView.register(ParentBankTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ParentBankTableViewHeader")
        tableView.register(BankTableViewCell.self, forCellReuseIdentifier: "BankTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureTableViewUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func buttonPressed(_ sender: Any?) {
        coordinator?.logout()
    }
    
    func fetchData() {
        viewModel.fetch()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            print("UPDATE !!!!!!")
            self?.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.banks[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.parentBanks.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ParentBankTableViewHeader") as? ParentBankTableViewHeader else {
            return nil
        }
        guard section < viewModel.parentBanks.count else { return nil }
        
        let vm = viewModel.parentBanks[section]
        view.setData(viewModel: vm)
        return view
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return viewModel.parentBanks[section].name
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell") as? BankTableViewCell else {
            return UITableViewCell()
        }
        let section = indexPath.section
        let row = indexPath.row
        guard section < viewModel.banks.count else { return UITableViewCell() }
        guard row < viewModel.banks[section].count else { return UITableViewCell() }
        
        let vm = viewModel.banks[section][row]
        cell.setData(viewModel: vm)
        return cell
    }
}

extension FeedViewController: SDWebImageManagerDelegate {
    func imageManager(_ imageManager: SDWebImageManager, transformDownloadedImage image: UIImage?, with imageURL: URL?) -> UIImage? {
        guard let image = image else { return nil }
        return image.cropAlpha()
    }
}
