//
//  NewReponseController.swift
//  Tip-stop
//
//  Created by Apprenant 163 on 06/08/2024.
//

import Foundation
import UIKit


class NewReponseController : UIViewController
{
    @IBOutlet weak var reponseTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sumbitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
    }
    
    ///Remet à jour les valeur initiaux de ces variables
    func resetForm()
    {
        sumbitButton.isEnabled = false
        errorLabel.isHidden = false
        errorLabel.text = "la zone de texte est vide"
        reponseTextField.text = ""
        
    }
    
    @IBAction func sumbitAction(_ sender: Any) 
    {
        resetForm()
    }
    @IBAction func reponseTextFieldChanged(_ sender: Any) 
    {
        if let reponseText = reponseTextField.text
        {
            if let errorMessage = invalidTextField(reponseText)
            {
                errorLabel.text = errorMessage
                errorLabel.isHidden = true
            }
            else
            {
                errorLabel.isHidden = false
            }
        }
            
    }
    ///Informe l'utilisateur que le champ de texte est vide
    func invalidTextField(_ value:String) -> String?
    {
        if value.count <= 0
        {
            return "la zone de texte est vide"
        }
        return nil
    }
    
    ///Active et désative le bouton si le formulaire n'est pas totalement rempli
    func checkForVaildForm()
    {
        if reponseTextField.isHidden
        {sumbitButton.isEnabled = true}
        else
            {sumbitButton.isEnabled = false}
        
    }
}
