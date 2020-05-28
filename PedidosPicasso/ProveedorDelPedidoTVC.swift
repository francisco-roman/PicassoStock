//
//  ProveedorDelPedidoTVC.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 3/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit


/**
 ** Protocolo ProductoPedidoDelegate
 **/

protocol ProductoPedidoDelegate {
    func pasaProveedor(nombreProveedor: String)
    func inicializaProductos(nombreProveedor: String)
}


class ProveedorDelPedidoTVC: UITableViewController {

        
    let proveedorManager = ProveedoresManager()
    var delegado: ProductoPedidoDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return proveedorManager.proveedores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaProveedor", forIndexPath: indexPath) as! PedidoProveedorTableViewCell

        let proveedor = proveedorManager.proveedores[indexPath.row]
        
        
        cell.imgProveedor.image = UIImage(data: proveedor.logo!)
        cell.lblProveedor.text = proveedor.nombre


        return cell
    }
    
    
    /*
    * override: Cuando se selecciona fila proveedor capturamos el nombre del proveedor en el delegado
    * en este caso ProductosTableViewController (que implementa el protocolo ProveedoresTVCDelegate)
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Pasa por delegado el proveedor
        delegado?.pasaProveedor(proveedorManager.proveedores[indexPath.row].nombre!)
        // Realiza por delegado inicialización de productos del proveedor con udsPedido a 0 
        delegado?.inicializaProductos(proveedorManager.proveedores[indexPath.row].nombre!)
    }

    /*
    * segue desde ProductosDelPedidoTVC
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueProductosPedido" {
            let navigation = segue.destinationViewController as! UINavigationController
            let vc = navigation.topViewController as! ProductosDelPedidoTVC
            delegado = vc
        }
    }


    @IBAction func unwindProveedorPedidoView(segue: UIStoryboardSegue) {
        
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
