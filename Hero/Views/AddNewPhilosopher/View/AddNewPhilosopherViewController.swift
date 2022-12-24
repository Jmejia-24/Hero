//
//  AddNewPhilosopherViewController.swift
//  Hero
//
//  Created by Byron Mejia on 12/23/22.
//

import UIKit

class AddNewPhilosopherViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var periodTextField: UITextField!
    @IBOutlet private var countryTextField: UITextField!
    @IBOutlet private var sentenceTextField: UITextField!
    @IBOutlet private var saveButton: UIButton!
    
    private lazy var imagePicker: ImagePicker = {
        ImagePicker(presentationController: self, delegate: self)
    }()
    
    private var nameImagePlaceholder = "uploadImage"
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
        imageView.image = UIImage(named: nameImagePlaceholder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageView.addGestureRecognizer(tap)
    }
    
    @objc func didTapImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        imagePicker.present(from: view)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let name = nameTextField.text,
              let period = periodTextField.text,
              let country = countryTextField.text,
              let sentence = sentenceTextField.text,
              !name.isEmpty,
              !period.isEmpty,
              !country.isEmpty,
              !sentence.isEmpty,
              nameImagePlaceholder.isEmpty,
              let image = imageView.image?.pngData() else {
            presentAlert(with: "Complete todos los campos para continuar")
            return
        }
        
        viewModel.save(name: name, period: period, country: country, sentence: sentence, imageDat: image)
        navigationController?.popViewController(animated: true)
    }
}

extension AddNewPhilosopherViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        DispatchQueue.main.async { [unowned self] in
            guard let image = image else { return }
            imageView.image = image
            nameImagePlaceholder = ""
        }
    }
}
