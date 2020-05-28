//
//  ProductosTableViewController.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 29/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit



class ProductosTableViewController: UITableViewController, ProveedoresTVCDelegate {

    

    var productoManager = ProductosManager()
    // utilizada para guardar el dato pasado por ProveedoresTVCDelegate
    var nombreMiProveedor: String?
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // El titulo de la tabla de productos de un proveedor es el nombre del proveedor
        self.title = "Productos de " + nombreMiProveedor!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    * Método del protocolo ProveedoresTVCDelegate
    */
    func pasaProveedor(nombreProveedor: String) {
        
        self.nombreMiProveedor = nombreProveedor
        
        productoManager.fetchProductos(nombreProveedor)
        
        self.tableView.reloadData()
    }
    

    /*
    * Pasa por segue a NuevoProductoViewController el proveedor
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Si se va a crear un nuevo producto le pasamos el proveedor a la vista hija
        if segue.identifier == "segueNuevoProducto" {
            
            let nuevoProductoVC = segue.destinationViewController as! NuevoProductoViewController
            nuevoProductoVC.nombreMiProveedor = self.nombreMiProveedor
        }        
    }
    
    
    /*
    * unwind desde NuevoProductoViewController
    */
    @IBAction func unwindProductosView(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "segueVolver" else {return}
        
        productoManager.fetchProductos(self.nombreMiProveedor!)
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CeldaProducto")! as! ProductosTableViewCell
        
        let producto = productoManager.productos[indexPath.row]
        
        
        cell.imgProducto.image = UIImage(data: producto.imagen!)
        cell.lblNombre.text = producto.nombre
        cell.lblStockBaja.text = producto.stockBaja?.stringValue
        cell.lblStockAlta.text = producto.stockAlta?.stringValue
        
        
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
                mostrarAlerta("Atención", mensaje: "Desea borrar de la BBDD a este producto?", sender: self, indexPath: indexPath)
        }
    }
    

    
    /*
    * Visualiza una alerta que permite borrar proveedor o cancelar la operación de borrado
    */
    func mostrarAlerta(titulo: String, mensaje: String, sender: AnyObject, indexPath: NSIndexPath) {
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .ActionSheet)
        
        let okAction = UIAlertAction(title: "Aceptar", style: .Default, handler: { action in
            self.productoManager.deleteProducto(indexPath.row)
            self.productoManager.fetchProductos(self.nombreMiProveedor!)
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
