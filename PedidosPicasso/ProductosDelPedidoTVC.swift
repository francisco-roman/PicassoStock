//
//  ProductosDelPedidoTVC.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 3/5/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//


import UIKit



class ProductosDelPedidoTVC: UITableViewController, ProductoPedidoDelegate {
    
    
    
    let productosManager = ProductosManager()
    var nombreMiProveedor: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // imprime el titulo de la vista del pedido con la fecha actual
        let hoy = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let convertedDate = dateFormatter.stringFromDate(hoy)
        self.title = (self.nombreMiProveedor!) + "  " + convertedDate
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    * Método del protocolo ProductoPedidoDelegate: Carga los productos del proveedor en el array productosManager
    */
    func pasaProveedor(nombreProveedor: String) {
        self.nombreMiProveedor = nombreProveedor
        
        productosManager.fetchProductos(nombreProveedor)
        
        self.tableView.reloadData()
    }
    
    
    /*
    * Método del protocolo ProductoPedidoDelegate: Inicializa a 0 las unidades de pedido para cada producto de este proveedor
    */
    func inicializaProductos(nombreProveedor: String) {
        
        var indice = 0
        while (indice < productosManager.productos.count) {
            
            productosManager.productos[indice].udsPedido = 0
            indice += 1
        }
    }
    
    /*
    * Al grabar un pedido se muestra un aviso de que ya se ha guardado el pedido
    */
    @IBAction func guardarPedido(sender: AnyObject) {
        
       
        var indice = 0
        var numeroDePedidos = 0
       // recorre el array de productos para comprobar que se ha introducido el stock en, al menos, un producto
        while (indice < productosManager.productos.count) {
            
            let unidades = productosManager.productos[indice].udsPedido
            if (unidades != 0) {
        
                numeroDePedidos += 1
            }
            
            indice += 1
        }
        // Si se ha pedido algo al menos de uno de sus productos
        if (numeroDePedidos > 0) {
            mostrarAlerta("Aviso", mensaje: "Tu pedido para el proveedor \(self.nombreMiProveedor!) ha sido guardado.", sender: sender)
        } else {
            mostrarAlerta("Aviso", mensaje: "Has guardado un pedido vacio.", sender: sender)
        }
 
        
    }
    
    
    
    /*
    * Visualiza una alerta
    */
    func mostrarAlerta(titulo: String, mensaje: String, sender: AnyObject) {
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .ActionSheet)
        
        let okAction = UIAlertAction(title: "Aceptar", style: .Default, handler: nil)
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }

     
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return productosManager.productos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("celdaProducto", forIndexPath: indexPath) as! PedidoProductoTableViewCell

        let producto = productosManager.productos[indexPath.row]
        
        
        cell.imgProducto.image = UIImage(data: producto.imagen!)
        cell.lblNombreProducto.text = producto.nombre
        
        if (producto.udsPedido == 0) {
            cell.lblUdsPedido.text = "0"
        }

        return cell
    }
 
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("celdaProducto", forIndexPath: indexPath) as! PedidoProductoTableViewCell
        
        let producto = productosManager.productos[indexPath.row]
        
        // actualiza fechaPedido y udsPedido del producto con los valores de la celda por si se han modificado
        producto.fechaPedido = NSDate()
        producto.udsPedido = Int(cell.lblUdsPedido.text!)

    }
    */
    

    
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
