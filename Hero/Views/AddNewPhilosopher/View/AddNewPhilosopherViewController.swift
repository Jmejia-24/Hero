//
//  AddNewPhilosopherViewController.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

class AddNewPhilosopherViewController: UIViewController {
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var periodTextField: UITextField!
    @IBOutlet private var countryTextField: UITextField!
    @IBOutlet private var sentenceTextField: UITextField!
    @IBOutlet private var saveButton: UIButton!
    
    private let viewModel: AddNewPhilosopherViewModelRepresentable
    
    init(viewModel: AddNewPhilosopherViewModelRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        title = "Agregar Filosofo"
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        
    }
}
