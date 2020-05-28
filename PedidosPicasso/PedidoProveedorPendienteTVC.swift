//
//  PedidoProveedorPendienteTVC.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 5/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit


/**
 ** Protocolo PedidoProveedorTVCDelegate
 **/
protocol PedidoProveedorTVCDelegate {
    func pasaProveedor(nombreProveedor: String)
}


class PedidoProveedorPendienteTVC: UITableViewController {

    
    let proveedorManager = ProveedoresManager()
    
    var delegado: PedidoProveedorTVCDelegate?

    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CeldaProveedor", forIndexPath: indexPath) as! PedidoProveedorPendienteTableViewCell

        let proveedor = proveedorManager.proveedores[indexPath.row]
        
        cell.imgProveedor.image = UIImage(data: proveedor.logo!)
        cell.lblNombreProveedor.text = proveedor.nombre

        return cell
    }
    
    
    // Override: cuando se selecciona fila proveedor capturamos el proveedor y se pasa por delegado
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegado?.pasaProveedor(proveedorManager.proveedores[indexPath.row].nombre!)
    }
    
    
    /*
    * segue para PedidoProductoPendienteTVC
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueProductosPendientes" {
            let navigation = segue.destinationViewController as! UINavigationController
            let vc = navigation.topViewController as! PedidoProductoPendienteTVC
            delegado = vc
        }
    }
    
    
    /*
    * unwind desde PedidoProductoPendienteTVC
    */
    @IBAction func unwindPedidoProveedorPendienteView(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "unwindPedidoProveedorPendiente" else {return}
        
        self.tableView.reloadData()
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
