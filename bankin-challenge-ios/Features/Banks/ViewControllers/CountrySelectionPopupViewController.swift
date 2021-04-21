//
//  CountrySelectionPopupViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 21/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit

final class CountrySelectionPopupViewController: UIViewController {
    
    weak var parentVC: BanksViewController?
    
    let tableViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let backgroundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let data: [Country] = [.france, .usa, .uk, .spain, .germany, .netherlands, .others]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureTableView()
        configureUI()
    }
    
    private func configureTableView() {
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.addSubview(backgroundButton)
        backgroundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundButton.addTarget(self, action: #selector(backgroundButtonPressed(_:)), for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.backgroundColor = .systemRed
        tableView.layer.borderWidth = 0.8
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.cornerRadius = 12
        tableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        let heightConstant = CGFloat(data.count * 45)
        tableView.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = true
    }
    
    @objc func backgroundButtonPressed(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

extension CountrySelectionPopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        guard row < data.count else { return UITableViewCell() }
        
        let model = data[row]
        cell.setData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = data[indexPath.row]
        self.parentVC?.currentCountry = country
        self.dismiss(animated: true, completion: nil)
    }
}
