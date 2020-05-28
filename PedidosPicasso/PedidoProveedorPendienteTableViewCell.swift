//
//  PedidoProveedorPendienteTableViewCell.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 5/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class PedidoProveedorPendienteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgProveedor: UIImageView!
    @IBOutlet weak var lblNombreProveedor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
