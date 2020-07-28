//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Serg on 04/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    var viewModel: FeedViewModelProtocol!
   
    private var arrayConstraints = [NSLayoutConstraint]()
    
    private weak var tableView: UITableView!
    
    private weak var footerView: FooterView!
    
    private weak var refreshControl: UIRefreshControl!
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        registerCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        registerCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        viewModel.state.bind { [weak self] vmState in
            guard let self = self else {
                return
            }
            switch vmState {
            case .initial: return
            case .readyShowItems(let firstIndex, let lastIndex):
                if !self.viewModel.readyNewsFeedItems.isEmpty {
                    DispatchQueue.main.async {
                        if firstIndex == 0 {
                            self.tableView.reloadData()
                        } else {
                            self.tableView.beginUpdates()
                            self.tableView.insertSections(IndexSet(integersIn: firstIndex...lastIndex), with: .bottom)
                            self.tableView.endUpdates()
                        }
                        self.cancelLoader()
                        self.endRefreshing()
                    }
                }
            case .showLoader: self.showLoader()
            }
        }
        viewModel.fetchNewsFeed()
    }
    
    private func registerCell() {
        let headerNib = UINib(nibName: HeaderNewsfeedCell.reuseIdentifier, bundle: Bundle(for: HeaderNewsfeedCell.self))
        tableView?.register(headerNib, forCellReuseIdentifier: HeaderNewsfeedCell.reuseIdentifier)
        let postTextNib = UINib(nibName: PostTextNewsfeedCell.reuseIdentifier, bundle: Bundle(for: PostTextNewsfeedCell.self))
        tableView?.register(postTextNib, forCellReuseIdentifier: PostTextNewsfeedCell.reuseIdentifier)
        let photoNib = UINib(nibName: PhotoNewsfeedCell.reuseIdentifier, bundle: Bundle(for: PhotoNewsfeedCell.self))
        tableView?.register(photoNib, forCellReuseIdentifier: PhotoNewsfeedCell.reuseIdentifier)
        let footerNib = UINib(nibName: FooterNewsfeedCell.reuseIdentifier, bundle: Bundle(for: FooterNewsfeedCell.self))
        tableView?.register(footerNib, forCellReuseIdentifier: FooterNewsfeedCell.reuseIdentifier)
        
        
    }
    
    @objc private func refreshAction(_ refreshControl: UIRefreshControl) {
        viewModel?.fetchNewsFeed()
    }
}

extension FeedViewController {
    func cancelLoader() {
        footerView.cancelLoader()
    }
    
    private func showLoader() {
        footerView.showLoader()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension FeedViewController {
    func layout() {
        let newTableView = UITableView()
        view.addSubview(newTableView)
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        let newTableViewTopAnchor = newTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let newTableViewBottomAnchor = newTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let newTableViewLeadingAnchor = newTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let newTableViewTrailingAnchor = newTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        self.tableView = newTableView
        
        let activityIndicator = FooterView()
        footerView = activityIndicator
        
        let refreshContrInstance: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
            return refreshControl
        }()
        refreshControl = refreshContrInstance
        
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        tableView.tableFooterView = footerView
        showLoader()
        
        NSLayoutConstraint.activate([newTableViewTopAnchor,
                                     newTableViewBottomAnchor,
                                     newTableViewLeadingAnchor,
                                     newTableViewTrailingAnchor])
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section)
        var cell: UITableViewCell!
        guard let model = viewModel?.cellViewModel(forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: type(of:model).reuseIdentifier, for: indexPath) as? HeaderNewsfeedCell {
            itemCell.viewModel = model as? NewsfeedHeaderCellModel
            cell = itemCell
        }
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath) as? PostTextNewsfeedCell {
            itemCell.viewModel = model as? NewsfeedTextCellModel
            cell = itemCell
        }
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath) as? PhotoNewsfeedCell {
            itemCell.viewModel = model as? NewsfeedPhotoCellModel
//            if let itemCellModel = itemCell.viewModel {
//                itemCell.config(size: CGSize(width: itemCellModel.width, height: itemCellModel.height))
//            }
            cell = itemCell
        }
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath) as? FooterNewsfeedCell {
            itemCell.viewModel = model as? NewsfeedFooterCellModel
            cell = itemCell
        }
        
        if indexPath.section == 101 {
            tableView.tableFooterView = FooterViewOverall()
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //MARK: scrollView.frame.size.height = высоте девайса!!!
        if footerView != nil && scrollView.contentOffset.y + scrollView.frame.size.height + 30 >= scrollView.contentSize.height {
            //footerView.showLoader()
            viewModel?.getNewData()
        }
    }
}




