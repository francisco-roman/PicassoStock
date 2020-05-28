//
//  NuevoProveedorViewController.swift
//  PedidosPicasso
//
//  Created by Fco. Javier Román on 27/4/20.
//  Copyright © 2020 Fco. Javier Román. All rights reserved.
//

import UIKit

class NuevoProveedorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var txtNuevoProveedor: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    let proveedoresManager = ProveedoresManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // asigna delegate del ImagePicker
        self.imagePicker.delegate = self
        self.txtNuevoProveedor.delegate = self
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
            imgLogo.contentMode = .ScaleAspectFit
            imgLogo.image = imagenSeleccionada
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
    
    
    /*
     * Cuando se toca en la vista
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
    *   Agrega un nuevo Proveedor
    */
    @IBAction func addNewProveedor(sender: AnyObject) {
        
        let nombre = self.txtNuevoProveedor.text
        
        let imagenPorDefecto = UIImage(named: "noDisponible")
        
        if (nombre != "") {
        // Añade el nuevo proveedor si no hay ya otro con ese nombre
            if proveedoresManager.noExisteProveedor(nombre!) {
                
                proveedoresManager.addNewProveedor(txtNuevoProveedor.text!, logo: imgLogo.image!)
                mostrarAlerta("Aviso", mensaje: "Has guardado en la BBDD al proveedor \(nombre!)", sender: sender)
                self.txtNuevoProveedor.text = ""
                self.imgLogo.image = imagenPorDefecto
            }
            else {
                mostrarAlerta("Aviso", mensaje: "Ya existe un proveedor con ese nombre", sender: sender)
                self.txtNuevoProveedor.text = ""
                self.imgLogo.image = imagenPorDefecto
            }
        }
        else {
            mostrarAlerta("Aviso", mensaje: "No has escrito el nombre del nuevo proveedor", sender: sender)
            self.imgLogo.image = imagenPorDefecto
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
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
