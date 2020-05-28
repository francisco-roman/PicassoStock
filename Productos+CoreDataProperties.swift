//
//  Productos+CoreDataProperties.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 11/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Productos {

    @NSManaged var fechaPedido: NSDate?
    @NSManaged var imagen: NSData?
    @NSManaged var nombre: String?
    @NSManaged var stockAlta: NSNumber?
    @NSManaged var stockBaja: NSNumber?
    @NSManaged var udsPedido: NSNumber?
    @NSManaged var numeroOrden: NSNumber?
    @NSManaged var pertenece: Proveedores?

}
