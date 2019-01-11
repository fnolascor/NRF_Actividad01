//
//  ViewController.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class WSStruct: Decodable{
    let status: Bool
    let message: String
    let id: String?
    let username: String?
    let age: String?
    let gender: String?
    let password: String?
    //Ejemplo parametro extra diferente tipo
    //let cursos: [Cursos]?
    init?(){
        return nil
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var lblCorreo: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var txtMensajes: UITextView!
    
    var base: BaseDatos = BaseDatos()
    var sesionCorrecta: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func login2()
    {
        var jsonResult: WSStruct?
        
        let request = URLRequest(url: URL(string: "\(Constantes.URL_DESA.apiWSLOGIN)?username=\(lblCorreo.text!)&password=\(lblPassword.text!.toBase64())")!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let info = data
            {
                do{
                    //let jsonResult = try JSONSerialization.jsonObject(with:; info) as! [String: AnyObject]
                    //print(jsonResult)
                    jsonResult = try JSONDecoder().decode(WSStruct.self, from: info)
                    //let response = response as? HTTPURLResponse
                    //if(response?.statusCode == 200) {
                    //DispatchQueue.main.async{
                    print(jsonResult?.id!)
                    print(jsonResult?.username!)
                    //}
                }catch{
                    print("Se produjo un error: \(error)")
                }
            }
            }.resume
    }
    
    @IBAction func callWS(_ sender: UIButton) {
        if(validaCampos())
        {
            let request = URLRequest(url: URL(string: "\(Constantes.URL_DESA.apiWSLOGIN)?username=\(lblCorreo.text!)&password=\(lblPassword.text!.toBase64())")!)
            
            //username: salvatore.isc@gmail.com
            //password: salvapunk
            
            let task = URLSession.shared.dataTask(with: request) {
                (data, resp, error) in
                if(error != nil)
                {
                    print("Se produjo el error \(error)")
                    self.txtMensajes.text = "Ocurrió un error, favor de intentarlo más tarde"
                }
                else
                {
                    if let info = data
                    {
                        do{
                            let jsonResult = try JSONSerialization.jsonObject(with: info) as! [String:AnyObject]
                            if let status = jsonResult["status"]{
                                if status as! Int == 1
                                {
                                    DispatchQueue.main.sync {
                                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                        let controller = storyBoard.instantiateViewController(withIdentifier: "idSesionIniciada")
                                        self.present(controller, animated: true, completion: nil)
                                    }
                                }
                                else
                                {
                                    self.txtMensajes.text = "Usuario no válido o datos incorrectos"
                                }
                            }
                        }catch{
                            self.txtMensajes.text = "Ocurrió un error, favor de intentarlo más tarde"
                        }
                    }
                    else
                    {
                        self.txtMensajes.text = "Ocurrió un error, favor de intentarlo más tarde"
                    }
                }
            }
            
            task.resume()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        limpiarCampos()
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
//        if let ident = identifier {
//            if ident == "loginSuccess" {
//                if(validaCampos())
//                {
//
//                }
//                else
//                {
//                    return false
//                }
//
//                if(validaCampos())
//                {
//                    let personaLogin: Persona = Persona.init(correoElectrónico: lblCorreo.text!, password: lblPassword.text!)
//                    let usuarioExiste: Bool = base.validaLoginUsuario(p: personaLogin)
//
//                    if(!usuarioExiste)
//                    {
//                        txtMensajes.text = "Datos incorrectos o Usuario inexistente, favor de validar o registrarse"
//                        return false
//                    }
//
//
//
//                    return true
//                }
//                return false
//            }
//        }
//        return true
//    }
    
    func validaCampos() -> Bool
    {
        if(!isValidEmail(testStr: lblCorreo.text!))
        {
            txtMensajes.text = "Correo no válido"
            return false;
        }
        return true;
    }
    
    func limpiarCampos()
    {
        lblCorreo.text = ""
        lblPassword.text = ""
        txtMensajes.text = ""
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

