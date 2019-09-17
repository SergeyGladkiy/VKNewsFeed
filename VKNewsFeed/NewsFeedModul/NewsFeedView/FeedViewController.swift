//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Serg on 04/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    var some = 0
    var viewModel: FeedViewModelProtocol!
   
    private var arrayConstraints = [NSLayoutConstraint]()
    
    private weak var tableView: UITableView!
    
    private lazy var footerView = FooterView()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(refreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        layout()
        registerCell()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableFooterView = footerView // add cell for it
        self.footerView.showLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        layout()
        registerCell()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.state.bind { [weak self] vmState in
            guard let self = self else {
                return
            }
            switch vmState {
            case .initial: return
            case .readyShowItems(let array):
                self.tableView.beginUpdates()
                //self.tableView.reloadRows(at: [IndexPath.init(row: self.viewModel.readyNewsFeedItems.observable.count - 1, section: 0)], with: .bottom)
                self.tableView.insertRows(at: array, with: .bottom)
                self.refreshControl.endRefreshing()
                self.tableView.endUpdates()
//                self.tableView.reloadData()
//                self.refreshControl.endRefreshing()
            case .newItemsReceived:
                return
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewModel?.fetchNewsFeed()
        }
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
        
        NSLayoutConstraint.activate([newTableViewTopAnchor,
                                     newTableViewBottomAnchor,
                                     newTableViewLeadingAnchor,
                                     newTableViewTrailingAnchor])
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            
            //let photos = itemCell.viewModel?.attachments ?? []
            let ratio = itemCell.viewModel?.ratio
            let width = UIScreen.main.bounds.width
            let height = width * (CGFloat(ratio!))
            //let height = width * (CGFloat(photos.first!.height) / CGFloat(photos.first!.width))
            itemCell.config(size: CGSize(width: width, height: height))
//            let photo = itemCell.viewModel?.attachments.min { arg1, arg2 in arg1.height < arg2.height }
////            print("Photo with min \(photo?.height)")
//            itemCell.config(size: CGSize(width: 0, height: photo?.height ?? 0))
            cell = itemCell
        }
        
        if let itemCell = tableView.dequeueReusableCell(withIdentifier: type(of: model).reuseIdentifier, for: indexPath) as? FooterNewsfeedCell {
            itemCell.viewModel = model as? NewsfeedFooterCellModel
            cell = itemCell
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastSectionIndex = tableView.numberOfSections - 1
//        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//            // print("this is the last cell")
//            let spinner = FooterView()
//            spinner.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//            spinner.showLoader()
//            self.tableView.tableFooterView = spinner
//        }
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            viewModel?.getNewData()
        }
    }
}



