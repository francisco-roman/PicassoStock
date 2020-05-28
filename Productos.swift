//
//  Productos.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 11/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class Productos: NSManagedObject {
    
    /*
    * Crea un objeto Producto y lo inserta en la BBDD
    */
    class func new(moc: NSManagedObjectContext, nombre: String, imagen: UIImage?, stockBaja: NSNumber, stockAlta: NSNumber, fechaPedido: NSDate, udsPedido: NSNumber?, proveedor: Proveedores) -> Productos {
        
        let newProducto = NSEntityDescription.insertNewObjectForEntityForName("Productos",
                                                                              inManagedObjectContext: moc) as! Productos
        
        newProducto.nombre = nombre
        newProducto.imagen = UIImagePNGRepresentation(imagen!)
        newProducto.stockBaja = stockBaja
        newProducto.stockAlta = stockAlta
        newProducto.fechaPedido = fechaPedido
        newProducto.udsPedido = udsPedido
        newProducto.pertenece = proveedor
        
        return newProducto
    }
    
    
    /*
    * Asigna proveedor al producto
    */
    func asignarProveedor(proveedor: Proveedores) {
        
        self.pertenece = proveedor
    }
    
    
    /*
    * Borra provedor del producto
    */
    func borrarProveedor() {
        
        self.pertenece = nil
    }
    
    
}

