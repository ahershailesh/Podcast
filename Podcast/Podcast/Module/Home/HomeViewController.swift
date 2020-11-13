//
//  ViewController.swift
//  Podcast
//
//  Created by Shailesh Aher on 11/11/20.
//

import UIKit


protocol HomeViewRepresentable {
    func loadData(completionBlock: ((Result<TableViewReloadType, Error>) -> Void))
    func fetchNextPage(completionBlock: (() -> Void))
    
    var sectons: [PodcastCategoryTableViewCellRepresentable] { get }
}

enum TableViewReloadType {
    case reload, intert(indexes: [Int]), delete(indexes: [Int]), update
}

class HomeViewModel: HomeViewRepresentable {
    private let interactor: PodcastAPIService
    
    private(set) var sectons: [PodcastCategoryTableViewCellRepresentable] = []
    
    init(interactor: PodcastAPIService = PodcastAPIService()) {
        self.interactor = interactor
    }
    
    func loadData(completionBlock: ((Result<TableViewReloadType, Error>) -> Void)) {
        interactor.fetchData { (result) in
            switch result {
            case .success(let curatedPodcast):
                sectons = curatedPodcast.curatedLists.map { PodcastCategoryTableViewCellViewModel(podcastList: $0) }
                completionBlock(.success(.reload))
            case .failure(let error):
                break
            }
        }
    }
    
    func fetchNextPage(completionBlock: (() -> Void)) {
        
    }
}

class HomeViewController: UIViewController {
    private var viewModel: HomeViewRepresentable?
    
    private lazy var tableView: UITableView = UITableView.construct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCells()
        setupConstraints()
    }
    
    func setup(viewModel: HomeViewRepresentable) {
        self.viewModel = viewModel
        viewModel.loadData { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    private func setupView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        navigationItem.title = "Home"
        navigationItem.largeTitleDisplayMode = .automatic 
        navigationController?.hidesBarsWhenVerticallyCompact = true
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
    }
    
    private func registerCells() {
        tableView.register(PodcastCategoryTableViewCell.self, forCellReuseIdentifier: PodcastCategoryTableViewCell.reuseId)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sectons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PodcastCategoryTableViewCell.reuseId, for: indexPath) as? PodcastCategoryTableViewCell
        if let viewModel = viewModel?.sectons[indexPath.row] {
            cell?.setup(viewModel: viewModel)
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
