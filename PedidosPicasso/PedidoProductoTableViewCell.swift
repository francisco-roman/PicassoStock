//
//  PedidoProductoTableViewCell.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 3/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class PedidoProductoTableViewCell: UITableViewCell, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var imgProducto: UIImageView!
    @IBOutlet weak var lblNombreProducto: UILabel!
    @IBOutlet weak var txtStock: UITextField!
    @IBOutlet weak var lblUdsPedido: UILabel!
    
    let productosManager = ProductosManager()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        lblUdsPedido.textColor = UIColor.redColor()
        // Modifica el delegaddo del textfield
        txtStock.delegate = self
        // Teclado numérico
        txtStock.keyboardType = UIKeyboardType.NumberPad
        // Indica que método se dispara al teclear sobre el textfield
        txtStock.addTarget(self, action: #selector(textOnTextFieldDidChange(_ :)), forControlEvents: UIControlEvents.EditingChanged)
    
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    /**
     * Tecla return pulsada
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  
    /**
     * Cuando se toca en la vista
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }

    
    /*
    * Si cambia el texto del textfield calcula el pedido
    */
    func textOnTextFieldDidChange(textField: UITextField) {
        if textField === txtStock {
            if Int(txtStock.text!) != nil {
                // actualiza la etiqueta con el pedido calculado
                let udsPedido = calculaPedido(Int(txtStock.text!)!)
                lblUdsPedido.text = String(stringInterpolationSegment: udsPedido)
                
                let producto = productosManager.dameProducto(lblNombreProducto.text!)
                producto?.udsPedido = Int(lblUdsPedido.text!)
                producto?.fechaPedido = NSDate()
                
                productosManager.saveDatabase()
                
            }

        }
 
    }
    
    /*
    * Calcula las unidades a pedir del producto en función de si es temporada baja o alta
    */
    func calculaPedido(hay: Int?) -> Int {
        
        var udsPedido:Int  = 0
        var stockMax:Int = 0
        
        let producto = productosManager.dameProducto(lblNombreProducto.text!)
        
        if esTemporadaAlta() {
            stockMax = (producto!.stockAlta?.integerValue)!
        } else {
            stockMax = (producto!.stockBaja?.integerValue)!
        }
        
        udsPedido = stockMax - hay!
        
        if (udsPedido < 0) {
            udsPedido = 0
        }
        
        return udsPedido
    }
    
    
    /*
    * Devuelve true si la fecha actual está entre 15/06 y 31/08 (temporada alta)
    */
    func esTemporadaAlta() -> Bool {
        
        let hoy = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: hoy)
        let year = components.year
        
        let inicioTemporadaBajaDateComponent = NSDateComponents()
        inicioTemporadaBajaDateComponent.day = 01
        inicioTemporadaBajaDateComponent.month = 09
        inicioTemporadaBajaDateComponent.year = year
        
        let inicioTemporadaAltaDateComponent = NSDateComponents()
        inicioTemporadaAltaDateComponent.day = 15
        inicioTemporadaAltaDateComponent.month = 06
        inicioTemporadaAltaDateComponent.year = year
        
        let inicioTemporadaBaja = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateFromComponents(inicioTemporadaBajaDateComponent)
        let inicioTemporadaAlta = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateFromComponents(inicioTemporadaAltaDateComponent)
        
        if (hoy.compare(inicioTemporadaAlta!) == .OrderedDescending) && (hoy.compare(inicioTemporadaBaja!) == .OrderedAscending) {
            return true
        }
        else {
            return false
        }
        
    }
    
  
}
