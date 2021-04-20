//
//  FeedViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

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
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
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
        return viewModel.banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        guard row < viewModel.banks.count else { return UITableViewCell() }
        
        let vm = viewModel.banks[row]
        cell.setData(viewModel: vm)
        return cell
    }
}
