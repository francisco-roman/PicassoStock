//
//  ProveedoresTableViewCell.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 28/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class ProveedoresTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    
}
