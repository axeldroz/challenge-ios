//
//  BanksViewController.swift
//  bankin-challenge-ios
//
//  Created by Axel Drozdzynski on 20/04/2021.
//  Copyright © 2021 Axel Drozdzynski. All rights reserved.
//

import UIKit
import SDWebImage

final class BanksViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var viewModel: BanksViewModelProtocol
    
    var currentCountry: Country = .FR {
        didSet {
            switchCountryButton.currentCountry = self.currentCountry
            viewModel.countryFilter = self.currentCountry
        }
    }
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let switchCountryButton: SwitchCountryButton = {
        let button = SwitchCountryButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: BanksViewModelProtocol = BanksViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = BanksViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SDWebImageManager.shared.delegate = self
        view.backgroundColor = .secondarySystemBackground
        configureUI()
        bindViewModel()
        fetchData()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureCollectionViewUI()
        configureCollectionView()
        configureSwitchButtonConstraints()
    }
    
    private func configureNavigationBar() {
        let logoutButton = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonPressed(_:)))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
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
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureSwitchButtonConstraints() {
        view.addSubview(switchCountryButton)
        
        switchCountryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        switchCountryButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        switchCountryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0).isActive = true
        switchCountryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0).isActive = true
        collectionView.topAnchor.constraint(equalTo: switchCountryButton.bottomAnchor, constant: 20).isActive = true
        
        switchCountryButton.addTarget(self, action: #selector(switchCountryButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func switchCountryButtonPressed(_ sender: Any?) {
        coordinator?.showCountrySelectionPopup()
    }
    
    @objc func buttonPressed(_ sender: Any?) {
        coordinator?.logout()
    }
    
    func fetchData() {
        viewModel.fetch()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension BanksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.parentBanks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.36, height: collectionView.frame.size.width * 0.36 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let addSomeSeparation: CGFloat = 10.0
        let collectionViewWidth: CGFloat = collectionView.frame.size.width
        let totalItemsWidth: CGFloat = collectionViewWidth * 0.36 * 2
        let totalMargin = collectionViewWidth - totalItemsWidth - 10.0 - addSomeSeparation
        let margin: CGFloat = totalMargin / 2.0
        return UIEdgeInsets(top: 20.0, left: margin, bottom: 10.0, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParentBankCollectionViewCell", for: indexPath) as? ParentBankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let row = indexPath.row
        let viewModels = viewModel.parentBanks
        guard row < viewModels.count else { return UICollectionViewCell() }
        
        let vm = viewModels[row]
        cell.setData(viewModel: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < viewModel.subBanks.count else { return }
        coordinator?.showSubBanks(subBanks: viewModel.subBanks[indexPath.item])
    }
}

extension BanksViewController: SDWebImageManagerDelegate {
    func imageManager(_ imageManager: SDWebImageManager, transformDownloadedImage image: UIImage?, with imageURL: URL?) -> UIImage? {
        guard let image = image else { return nil }
        return image.cropAlpha()
    }
}
