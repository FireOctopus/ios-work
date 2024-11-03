//
//  TextedCatContoller.swift
//  Catarator
//
//  Created by Oleg Fadeev on 03.11.2024.
//

import UIKit

class TextedCatController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var textInput: UITextField!
    
    @IBOutlet weak var generationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statusLabel.text = "Готов к загрузке!"
        activityIndicator.hidesWhenStopped = true
        
        //generationButton.isEnabled = false
        
    }
    
    private func downloadCat(with text: String) {
        guard let url = URL(string: "https://cataas.com/cat" + ((text.isEmpty) ? "" : "/says/\(text)?fontSize=50&fontColor=white")
        ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.catImageView.image = UIImage(data: data)
                self?.statusLabel.text = "Загрузка кота закончена"
                self?.activityIndicator.stopAnimating()
                self?.generationButton.isEnabled = true
            }
        }
        
        task.resume()
    }

    
    @IBAction func didTapButton(_ sender: Any) {
        activityIndicator.startAnimating()
        statusLabel.text = "Начинаю загрузку кота!"
        generationButton.isEnabled = false
        downloadCat(with: textInput.text!)
    }
    
    @IBAction func input(_ sender: Any) {
        if textInput.isEditing {
            generationButton.isEnabled = true
        }
    }
}

