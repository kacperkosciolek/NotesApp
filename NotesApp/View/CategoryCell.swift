//
//  CategoryCell.swift
//  NotesApp
//
//  Created by Kacper on 05/09/2021.
//  Copyright © 2021 Kacper Kosciolek. All rights reserved.
//

import UIKit
import CoreData


class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryTrash: UIButton!
    
    @IBOutlet weak var CategoryView: UIView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var categoryDate: UILabel!

//    @IBOutlet weak var arrow: UIButton!
    
    static let cellHeight: CGFloat = 200
    static let cellID = "CategoryCell"
    
    var buttonAction: ((UIButton) -> Void)?
    
    @IBAction func categoryTrashBtn(_ sender: UIButton) {
        self.buttonAction?(sender)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
        self.categoryTrash.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20))
     
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
