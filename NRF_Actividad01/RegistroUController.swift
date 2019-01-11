//
//  RegistroUController.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class RegistroUController: UIViewController {
    
    var base: BaseDatos = BaseDatos()
    
    @IBOutlet weak var txtNombreCompleto: UITextField!
    @IBOutlet weak var txtCorreoElectronico: UITextField!
    @IBOutlet weak var txtNumeroEmpleado: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var dpFechaNacimiento: UIDatePicker!
    @IBOutlet weak var txtContraseña: UITextField!
    @IBOutlet weak var txtConfirmaContraseña: UITextField!
    @IBOutlet weak var txtMensajes: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        limpiarCamnpos()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "registroExitoso" {
                
                if(validaCampos())
                {
                    let usuarioExiste: Bool = base.validaExisteUsuario(numeroEmpleado: Int(txtNumeroEmpleado.text!)!)
                    
                    if(usuarioExiste)
                    {
                        txtMensajes.text = "El emplado \(txtNumeroEmpleado.text!) ya existe, favor de ingresar sus credenciales o recuperar su contraseña"
                        
                        return false
                    }
                    limpiarCamnpos()
                    return true
                }
                return false
            }
        }
        return true
    }
    
    func validaCampos() -> Bool
    {
        if(isValidEmail(testStr: txtCorreoElectronico.text!))
        {
            if(isValidEmployee(value: txtNumeroEmpleado.text!))
            {
                if(isValidNumber(value: txtTelefono.text!))
                {
                    return true
                }
                
                txtMensajes.text = "Teléfono no válido"
                return false
            }
            txtMensajes.text = "Número de empleado no válido"
            return false;
        }
        else
        {
            txtMensajes.text = "Correo electrónico no valido"
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmployee(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{6}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func limpiarCamnpos()
    {
        txtNombreCompleto.text = ""
        txtCorreoElectronico.text = ""
        txtNumeroEmpleado.text = ""
        txtTelefono.text = ""
        dpFechaNacimiento.setDate(Date(), animated: false)
        txtContraseña.text = ""
        txtConfirmaContraseña.text = ""
        txtMensajes.text = ""
    }
}
