//
//  ProductosManager.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 29/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProductosManager {
    
    let moc = (UIApplication.sharedApplication().delegate as!
        AppDelegate).managedObjectContext
    
    var productos = [Productos]()
    
    /*
    * Inicializador por defecto
    */
    init () {
        fetchProductos()
    }
    
    
   /*
    * Inicializador para un proveedor concreto
    */
    init(proveedor: Proveedores) {
        fetchProductos(proveedor.nombre!)
    }
    
    
    /*
    * Añade un nuevo objeto Producto y lo guarda en la BBDD
    */
    func addNewProducto(nombre: String, imagen: UIImage?, stockBaja: NSNumber, stockAlta: NSNumber,
                        fechaPedido: NSDate, udsPedido: NSNumber?, proveedor: Proveedores) {
        
        _ = Productos.new(moc, nombre: nombre, imagen: imagen, stockBaja: stockBaja, stockAlta: stockAlta, fechaPedido: fechaPedido, udsPedido: udsPedido, proveedor: proveedor)
        
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
    * Obtiene los productos de la BBDD volcados en el array productos
    */
    func fetchProductos() {
        let fetchRequest = NSFetchRequest(entityName: "Productos")
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest))
            as? [Productos] {
            productos = fetchResults
        }
    }
    
    
    /*
    * Obtiene los productos de la BBDD que pertenecen a un proveedor
    */
    func fetchProductos(nombreProveedor: String) {
        
        let predicate = NSPredicate(format: "pertenece.nombre CONTAINS %@", nombreProveedor)
     //   let sortDescriptor = NSSortDescriptor(key: "numeroOrden", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Productos")
        fetchRequest.predicate = predicate
     //   fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest))
            as? [Productos] {
            productos = fetchResults
        }
    }
    
    
    /*
    * Borra objeto Producto de la BBDD
    */
    func deleteProducto(indice: Int) {
        if indice < productos.count {
            moc.deleteObject(productos[indice])
        }
        
        saveDatabase()
    }
    
    
    /*
    * Devuelve el producto con este nombre si existe
    */
    func dameProducto(nombre: String) -> Productos? {
        
        let predicate = NSPredicate(format: "nombre CONTAINS %@", nombre)
        let fetchRequest = NSFetchRequest(entityName: "Productos")
        fetchRequest.predicate = predicate
        if let fetchResults = (try? moc.executeFetchRequest(fetchRequest)) as? [Productos] {
            productos = fetchResults
        }
        
        if productos.count == 1 {
            return productos[0]
        }
        else {
            return nil
        }
    }
    
    
}
