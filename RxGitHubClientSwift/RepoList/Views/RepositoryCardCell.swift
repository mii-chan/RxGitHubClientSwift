//
//  RepositoryCardCell.swift
//  RxGitHubClientSwift
//
//  Created by Yuki Miida on 2018/02/05.
//

import UIKit
import PINRemoteImage

class RepositoryCardCell: UITableViewCell {
    
    @IBOutlet weak var avatarOutlet: UIImageView!
    @IBOutlet weak var fullNameOutlet: UILabel!
    @IBOutlet weak var forkOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var stargazersCountOutlet: UILabel!
    @IBOutlet weak var forksCountOutlet: UILabel!
    
    static func register(with tableView: UITableView) {
        tableView.register(Nib.nib(self), forCellReuseIdentifier: self.identifier)
    }
    
    static func dequeue(from tableView: UITableView, repo: Repository) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as? RepositoryCardCell else { fatalError("\(self.identifier) must be registered") }
        
        if let url = URL(string: repo.owner.avatarURL) {
            cell.avatarOutlet.pin_updateWithProgress = true
            cell.avatarOutlet.pin_setImage(from: url)
        }
        
        cell.fullNameOutlet.text = repo.fullName
        cell.forkOutlet.isHidden = !repo.fork
        cell.descriptionOutlet.text = repo.description ?? ""
        cell.stargazersCountOutlet.text = "\(repo.stargazersCount)"
        cell.forksCountOutlet.text = "\(repo.forksCount)"
        
        return cell
    }
}
