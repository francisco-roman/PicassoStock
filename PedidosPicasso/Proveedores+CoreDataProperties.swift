//
//  Proveedores+CoreDataProperties.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 1/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Proveedores {

    @NSManaged var logo: NSData?
    @NSManaged var nombre: String?
    @NSManaged var ofrece: NSSet?

}
