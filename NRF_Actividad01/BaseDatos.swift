//
//  BaseDatos.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import Foundation

struct BaseDatos
{
    var lstPersonas = [Persona]()
    
    init()
    {
        lstPersonas.append(francisco)
        lstPersonas.append(ray)
        lstPersonas.append(mike)
    }
    
    let francisco: Persona = Persona.init(nombreCompleto: "Francisco Nolasco Reyes", correoElectrónico: "nolascorf@gmail.com", noEmpleado: 307091, telefono: 74410673793, fechaNacimiento: "09/06/1989", password: "Francisco89")
    
    let ray: Persona = Persona.init(nombreCompleto: "Raymundo Jesús Sánchez Murillo", correoElectrónico: "rjsanchez@elektra.com.mx", noEmpleado: 701617, telefono: 7712202872, fechaNacimiento: "10/11/1990", password: "Raymundo90")
    
    let mike: Persona = Persona.init(nombreCompleto: "Miguel Osbaldo Gallardo Toledo", correoElectrónico: "mosbald9@gmail.com", noEmpleado: 567890, telefono: 7442450893, fechaNacimiento: "24/07/1991", password: "MiguelOsbaldo91")
    
    func validaLoginUsuario(p: Persona) -> Bool
    {
        for persona in self.lstPersonas{
            if(persona.correoElectrónico == p.correoElectrónico && persona.password == p.password)
            {
                return true
            }
        }
        
        return false
    }
    
    func resetPasswod(correo: String) -> String
    {
        for persona in self.lstPersonas{
            if(persona.correoElectrónico == correo)
            {
                return "La contraseña fue enviada con éxito a su coreo electrónico"
            }
        }
        
        return "Correo inexistente en sistema, favor de validar"
    }
    
    func validaExisteUsuario(numeroEmpleado: Int) -> Bool
    {
        for persona in self.lstPersonas{
            if(persona.noEmpleado == numeroEmpleado)
            {
                return true
            }
        }
        
        return false
    }
}
