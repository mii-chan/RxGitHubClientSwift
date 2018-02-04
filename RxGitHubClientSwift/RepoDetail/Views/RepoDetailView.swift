//
//  RepoDetailView.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit

class RepoDetailView: UIView {
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
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
