//
//  PedidoProductoPendienteTVC.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 5/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit
import Foundation


class PedidoProductoPendienteTVC: UITableViewController,  PedidoProveedorTVCDelegate {
    
    
    let productoManager = ProductosManager()
    
    var nombreMiProveedor: String?

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Calculo de la fecha del pedido (será la fecha de cualquier producto de este proveedor)
        var fechaPedido = NSDate()
        
        productoManager.fetchProductos(self.nombreMiProveedor!)
        
        if (productoManager.productos.count > 0) {
            fechaPedido = productoManager.productos[0].fechaPedido!
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let convertedDate = dateFormatter.stringFromDate(fechaPedido)
        
        self.title = (self.nombreMiProveedor)! + "  " + convertedDate
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    * Método del protocolo PedidoProveedorTVCDelegate
    */
    func pasaProveedor(nombreProveedor: String){
        
        self.nombreMiProveedor = nombreProveedor
        
        productoManager.fetchProductos(nombreProveedor)
        
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return productoManager.productos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CeldaProductoPendiente", forIndexPath: indexPath) as! PedidoProductoPendienteTableViewCell

        let producto = productoManager.productos[indexPath.row]
        
        cell.imgProducto.image = UIImage(data: producto.imagen!)
        cell.lblNombreProducto.text = producto.nombre
        
        if (producto.udsPedido != nil) {
            cell.lblUdsPedido.text = producto.udsPedido?.stringValue
        }
        else {
            cell.lblUdsPedido.text = "0"
        }
        

        return cell
    }
    

    /*
    * Botón compartir (Action): se prepara el texto con el pedido y lo comparte con otras aplicaciones a través de IOS
    */
    @IBAction func compartirPedido(sender: AnyObject) {
        
        let pedido = self.formateaPedido()
        
        let activityController = UIActivityViewController(activityItems: [pedido], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        
        presentViewController(activityController, animated: true, completion: nil)
    }
 
    
    
    /*
    * Devuelve un String con el texto del pedido
    */
    func formateaPedido() -> String {
        
        var pedido: String
        let productos = productoManager.productos
        // Formatea la fecha
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let convertedDate = dateFormatter.stringFromDate(productos[0].fechaPedido!)
    
        pedido = ("Hola. Pedido de Chiringuito Picasso (" + convertedDate + "):  ")
        var indice = 0
        while indice < productos.count {
            
            pedido += (productos[indice].nombre! + "  " + (productos[indice].udsPedido?.stringValue)!) + ", "
            indice += 1
        }
        
        return pedido
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
