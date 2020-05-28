//
//  ProductosTableViewCell.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 30/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class ProductosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblStockBaja: UILabel!
    @IBOutlet weak var lblStockAlta: UILabel!
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblStockBaja.textColor = UIColor.redColor()
        lblStockAlta.textColor = UIColor.redColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    

}
