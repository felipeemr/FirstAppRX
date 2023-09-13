//
//  UserCell.swift
//  FirstAppRX
//
//  Created by Felipe Moraes Rocha on 11/07/22.
//

import UIKit

class UserCell: UITableViewCell{
    
    static let starTintColor = UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0)
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    func configureCell(userdetail: UserDetailModel){
        userName.text = userdetail.userData.first_name ?? ""
        if userdetail.isFavorite.value{
            favoriteImage.image = UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor)
        }else {
            favoriteImage.image = UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor)
        }
    }
}
