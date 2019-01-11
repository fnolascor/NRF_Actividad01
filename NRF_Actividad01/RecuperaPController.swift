//
//  RecuperaPController.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class RecuperaPController: UIViewController {
    var base: BaseDatos = BaseDatos()
    
    
    @IBOutlet weak var txtCorreoElectronico: UITextField!
    @IBOutlet weak var txtMensajes: UITextView!
    
    
    @IBAction func btnRecuperaPassword(_ sender: UIButton) {
        txtMensajes.text = base.resetPasswod(correo: txtCorreoElectronico.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        limpiarCampos()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func limpiarCampos()
    {
        txtCorreoElectronico.text = ""
        txtMensajes.text = ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
