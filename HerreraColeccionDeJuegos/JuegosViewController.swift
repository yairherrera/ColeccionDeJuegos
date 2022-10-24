//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicked.sourceType = .photoLibrary
        present(imagePicked, animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = s.image?.jpegData(compressionQuality: 0.50)
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = s.image?.jpegData(compressionQuality: 0.50)
        }
    }
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var s: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizacionBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    
    var imagePicked = UIImagePickerController()
    var juego: Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicked.delegate = self
        
        if juego != nil {
            s.image = UIImage(data: (juego!.imagen!)as Data)
            tituloTextField.text = juego!.titulo
            agregarActualizacionBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSleccionada = info[.originalImage] as? UIImage
        s.image = imagenSleccionada
        imagePicked.dismiss(animated: true, completion: nil)
    }
}
