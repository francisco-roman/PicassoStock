//
//  Proveedores.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 1/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class Proveedores: NSManagedObject {

   
    /*
    * Crea un objeto Proveedor y lo inserta en la BBDD
    */
    class func new(moc: NSManagedObjectContext, nombre: String, logo: UIImage?) -> Proveedores {
        let newProveedor = NSEntityDescription.insertNewObjectForEntityForName("Proveedores",
                                                                               inManagedObjectContext: moc) as! Proveedores
        newProveedor.nombre = nombre
        newProveedor.logo = UIImagePNGRepresentation(logo!)
        
        return newProveedor
    }
    
    /*
    * Asigna producto al proveedor
    */
    func dameProducto(producto: Productos) {
        
        var set = self.ofrece as! Set<Productos>
        set.insert(producto)
        producto.asignarProveedor(self)
        self.ofrece = set
    }
    
    /*
    * Borra producto del proveedor
    */
    func quitaProducto(producto: Productos) {
        
        var set = ofrece as! Set<Productos>
        if set.contains(producto) {
            set.remove(producto)
            producto.borrarProveedor()
        }
        ofrece = set
    }

}
