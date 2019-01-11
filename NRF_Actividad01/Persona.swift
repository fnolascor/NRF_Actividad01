//
//  Persona.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import Foundation

class Persona
{
    var nombreCompleto: String = ""
    var correoElectrónico: String = ""
    var noEmpleado: Int = 0
    var telefono: Int = 0
    var fechaNacimiento: String = ""
    var password: String = ""
    
    init(correoElectrónico: String, password: String)
    {
        self.correoElectrónico = correoElectrónico
        self.password = password
    }
    
    init(nombreCompleto: String, correoElectrónico: String, noEmpleado: Int, telefono: Int, fechaNacimiento: String, password: String)
    {
        self.nombreCompleto = nombreCompleto
        self.correoElectrónico = correoElectrónico
        self.noEmpleado = noEmpleado
        self.telefono = telefono
        self.fechaNacimiento = fechaNacimiento
        self.password = password
    }
}
