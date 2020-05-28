//
//  PedidoProductoPendienteTableViewCell.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 5/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class PedidoProductoPendienteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblNombreProducto: UILabel!
    @IBOutlet weak var lblUdsPedido: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblUdsPedido.textColor = UIColor.redColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
