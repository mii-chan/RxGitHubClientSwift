//
//  RepoListView.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

class RepoListView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.textField?.leftView = nil
            searchBar.searchTextPositionAdjustment = UIOffsetMake(8.0, 0.0)
            searchBar.isHidden = true
        }
    }
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            RepositoryCardCell.register(with: tableview)
        }
    }
    
    @IBOutlet weak var errorViewOutlet: UIView!
    @IBOutlet weak var errorStackViewOutlet: UIStackView!
    @IBOutlet weak var errorMessageOutlet: UILabel!
    @IBOutlet weak var refreshButtonOutlet: UIButton!
    
    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = Nib.view(self) else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        AutoLayout.fill(self, with: view)
    }
}
