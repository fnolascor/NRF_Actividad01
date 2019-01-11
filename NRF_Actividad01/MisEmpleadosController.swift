//
//  MisEmpleadosController.swift
//  NRF_Actividad01
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class MisEmpleadosController: UIViewController {
    
    @IBOutlet weak var tblEmpleados: UITableView!
    var contactos = ["R": ["Raymundo Jesús Sánchez Murillo", "Rogelio López Gómez"], "F": ["Francisco Nolasco Reyes"], "M": ["Miguel Osbaldo Gallardo Toledo"], "J": ["Jonatan Rebolledo Sánchez", "Jazmin Valentina Salazar Velázquez"]]

    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    var personaSeleccionada: String?
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblEmpleados.dataSource = self
        tblEmpleados.delegate = self
        tblEmpleados.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        
        // SORTING [SINCE A DICTIONARY IS AN UNSORTED LIST]
        let sortedBreeds = contactos.sorted(by: { $0.0 < $1.0 })
        for (key, value) in sortedBreeds {
            print("\(key) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let personaSelec = contactos[tblContactos.indexPathForSelectedRow]
        if segue.identifier == "idRutaEmpleado"{
            if let vcd = segue.destination as? RutasCobranzaController{
                vcd.nombreEmpleado = self.personaSeleccionada
            }
        }
        
    }
}

extension MisEmpleadosController:  UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idEmpleado", for: indexPath)
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        var textoCelda: String? = cell.textLabel?.text!
        
        if(textoCelda == "Francisco Nolasco Reyes" || textoCelda == "Jazmin Valentina Salazar Velázquez" || textoCelda == "Rogelio López Gómez")
        {
            cell.accessoryType = .detailDisclosureButton
            cell.backgroundColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectArray[section].sectionName
    }
}

extension MisEmpleadosController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        personaSeleccionada = objectArray[indexPath.section].sectionObjects[indexPath.row]
        if(personaSeleccionada == "Francisco Nolasco Reyes" || personaSeleccionada == "Jazmin Valentina Salazar Velázquez" || personaSeleccionada == "Rogelio López Gómez")
        {
            performSegue(withIdentifier: "idRutaEmpleado", sender: nil)
        }
    }
    
    
}
