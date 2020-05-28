//
//  ProveedoresManager.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 27/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ProveedoresManager {
    
    let moc = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    var proveedores = [Proveedores]()
    
    
    
    init() {
        fetchProveedores()
    }
    
    
    
    /*
    * Añade nuevo objeto Proveedor y guarda cambios en la BBDD
    */
    func addNewProveedor(nombre: String, logo: UIImage?) {
        
        _ = Proveedores.new(moc, nombre: nombre, logo: logo)
        
        saveDatabase()
   
    }
    
    
    /*
    * Graba los cambios en la BBDD
    */
    func saveDatabase() {
        do {
            try moc.save()
        } catch {
        }
    }
    
    
    /*
    * Obtiene los proveedores de la BBDD volcados en el array proveedores
    */
    func fetchProveedores() {
        let fetchRequest = NSFetchRequest(entityName: "Proveedores")
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest))
            as? [Proveedores] {
            proveedores = fetchResults
        }
    }
    
    
    
    /*
    * Devuelve true si existe el proveedor
    */
    func noExisteProveedor(nombre: String) -> Bool {
        
        let predicate = NSPredicate(format: "nombre CONTAINS %@", nombre)
        let fetchRequest = NSFetchRequest(entityName: "Proveedores")
        fetchRequest.predicate = predicate
        if ((try? moc.executeFetchRequest(fetchRequest))
            as? [Proveedores])?.count == 0 {
            return true
        } else {
            return false
        }

    }
    
    
    
    /*
    * Deuelve el proveedor con este nombre
    */
    func dameProveedor(nombre: String) -> Proveedores? {
        //var suProveedor = Proveedores()
        
        let predicate = NSPredicate(format: "nombre CONTAINS %@", nombre)
        let fetchRequest = NSFetchRequest(entityName: "Proveedores")
        fetchRequest.predicate = predicate
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest))
            as? [Proveedores] {
            //suProveedor = fetchResults[0]
            return fetchResults[0]
        }
        /*
        if suProveedor.count == 1 {
            return susProveedores
        }
        else {
            return nil
        }
        */
        
        return nil
 
    }
    
    
    /*
    * Borra objeto Proveedor de la BBDD
    */
    func deleteProveedor(indice: Int) {
        if indice < proveedores.count {
            moc.deleteObject(proveedores[indice])
        }
        
        saveDatabase()
    }
    
    
}
