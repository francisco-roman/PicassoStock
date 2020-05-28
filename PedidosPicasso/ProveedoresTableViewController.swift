//
//  ProveedoresTableViewController.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 27/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit


/**
 ** Protocolo Delegado
 **/

protocol ProveedoresTVCDelegate {
    func pasaProveedor(nombreProveedor: String)
}


class ProveedoresTableViewController: UITableViewController {
    
    
    let proveedorManager = ProveedoresManager()
    
    var delegado: ProveedoresTVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    * unwind desde NuevoProveedorTCV
    */
    @IBAction func unwindToProveedoresList(segue: UIStoryboardSegue) {
      
        guard segue.identifier == "segueVolver" else { return }
        
        proveedorManager.fetchProveedores()
        
        self.tableView.reloadData()
    }
    
    
   
        
        // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return proveedorManager.proveedores.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CeldaProveedor")! as! ProveedoresTableViewCell
        
        let proveedor = proveedorManager.proveedores[indexPath.row]
        
        
        cell.imgLogo.image = UIImage(data: proveedor.logo!)
        cell.lblNombre.text = proveedor.nombre
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            mostrarAlerta("Atención", mensaje: "Desea borrar de la BBDD a este proveedor? Se borrarán también todos sus productos.", sender: self, indexPath: indexPath)
            
        }
    }
    

    // Override cuando se selecciona fila proveedor capturamos el nombre del proveedor en el delegado
    // en este caso ProductosTableViewController (que implementa el protocolo ProveedoresTVCDelegate)
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegado?.pasaProveedor(proveedorManager.proveedores[indexPath.row].nombre!)
    }
   
    
    /*
    * override: Pasa delegado a ProductosTableViewController
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueProductos" {
            let navigation = segue.destinationViewController as! UINavigationController
            let vc = navigation.topViewController as! ProductosTableViewController
            delegado = vc
        }
    }
    

 
    /*
    * Visualiza una alerta que permite borrar proveedor o cancelar la operación de borrado
    */
    func mostrarAlerta(titulo: String, mensaje: String, sender: AnyObject, indexPath: NSIndexPath) {
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .ActionSheet)
        
        let okAction = UIAlertAction(title: "Aceptar", style: .Default, handler: { action in
            self.proveedorManager.deleteProveedor(indexPath.row)
            self.proveedorManager.fetchProveedores()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)})
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
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
