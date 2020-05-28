//
//  NuevoProductoViewController.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 30/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit
import CoreData


class NuevoProductoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtStockBaja: UITextField!
    @IBOutlet weak var txtStockAlta: UITextField!
    @IBOutlet weak var imgProducto: UIImageView!

    
    // se le pasa por segue el proveedor desde ProductoTableViewController
    var nombreMiProveedor: String?
        
    let imagePicker = UIImagePickerController()
    
    var productosManager = ProductosManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // asigna delegate del ImagePicker
        self.imagePicker.delegate = self
        self.txtNombre.delegate = self
        self.txtStockBaja.delegate = self
        self.txtStockAlta.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     * Muestra opción de fuente para el ImagePicker al pulsar sobre la imagen: Cámara o Galería
     */
    @IBAction func mostrarImagePicker(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Elija Imagen", message: nil, preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Cámara", style: .Default, handler: { _ in self.openCamera() }))
        alert.addAction(UIAlertAction(title: "Galería", style: .Default, handler: { _ in self.openGallery() }))
        alert.addAction(UIAlertAction.init(title: "Cancelar", style: .Cancel, handler: nil))
        
        alert.popoverPresentationController?.sourceView = sender as? UIView
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    /*
     * Abre la cámara para el ImagePicker
     */
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Aviso", message: "No tienes cámara disponible", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    /*
     * Muestra la galería para el ImagePicker
     */
    func openGallery()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
  
    /*
    * Asigna la imagen seleccionada y sale del ImagePicker
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgProducto.contentMode = .ScaleAspectFit
            imgProducto.image = imagenSeleccionada
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
     * Tecla return pulsada
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Cuando se toca en la vista
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    /*
    * Agrega un nuevo Producto
    */
    @IBAction func addProducto(sender: AnyObject) {
        
        let nombre = self.txtNombre.text
        let stockBaja = self.txtStockBaja.text
        let stockAlta = self.txtStockAlta.text
        
        let imagenPorDefecto = UIImage(named: "noDisponible")
        
        
        let proveedoresManager = ProveedoresManager()
        let miProveedor = proveedoresManager.dameProveedor(self.nombreMiProveedor!)
        
        
        if (nombre != "") && (Int(stockBaja!) != nil) && (Int(stockAlta!) != nil) && (miProveedor != nil) {
        // Añade el nuevo producto si no hay otro con el mismo nombre
            if (noExisteProducto(nombre!) == nil) {
                               
                productosManager.addNewProducto(txtNombre.text!, imagen: imgProducto.image, stockBaja: Int(txtStockBaja.text!)!, stockAlta: Int(txtStockAlta.text!)!, fechaPedido: NSDate(), udsPedido: 0, proveedor: miProveedor!)
                                
                mostrarAlerta("Aviso", mensaje: "Has guardado el producto \(nombre!) en la BBDD", sender: sender)
                self.txtNombre.text = ""
                self.txtStockBaja.text = ""
                self.txtStockAlta.text = ""
                self.imgProducto.image = imagenPorDefecto
            }
            else {
                mostrarAlerta("Aviso", mensaje: "Ya existe un producto de algún proveedor con ese nombre", sender: sender)
                self.txtNombre.text = ""
                self.txtStockBaja.text = ""
                self.txtStockAlta.text = ""
                self.imgProducto.image = imagenPorDefecto
            }

        }
        else {
            mostrarAlerta("Aviso", mensaje: "No has introducido todos los campos con el formato correcto", sender: sender)
            self.txtNombre.text = ""
            self.txtStockBaja.text = ""
            self.txtStockAlta.text = ""
            self.imgProducto.image = imagenPorDefecto
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
   
    
    /*
    * Devuelve nil si no hay almacenado en la BBDD un producto con ese nombre
    */
    func noExisteProducto(nombre: String) -> Productos? {
        
        let aux = ProductosManager().dameProducto(nombre)
        
        return aux
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
