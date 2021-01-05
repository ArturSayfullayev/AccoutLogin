//
//  ViewController.swift
//  AutorisedAccount
//
//  Created by Artur on 1/2/21.
//

import UIKit
    // MARK: - Properties
var password: String = ""
var allert: String = ""


    // MARK: - Errors Enum
enum LoginErrors: Error {
    case invalidEmail
    case invalidPassword
    case emptyFieldEmail
    case emptyFieldPassword
}

    // MARK: - Util Class
class Utils {
    static func getPassword() {
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        password = String((0...7).compactMap{ _ in passwordCharacters.randomElement() })
        print(password)
    }
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var myView: UIView! {
        didSet {
            self.myView.layer.cornerRadius = 25
            self.myView.layer.shadowRadius = 17
            self.myView.layer.shadowColor = UIColor.black.cgColor
            self.myView.layer.shadowOpacity = 0.8
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.image = UIImage(named: "LoginImage-1")
            self.imageView.layer.cornerRadius = 25
            self.imageView.layer.borderWidth = 3
            self.imageView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var textLogin: UITextField! {
        didSet {
            self.textLogin.clearButtonMode = .always
            self.textLogin.placeholder = "Enter your e-mail"
        }
    }
    
    @IBOutlet weak var textPassword: UITextField! {
        didSet {
            self.textPassword.clearButtonMode = .always
            self.textPassword.placeholder = "Enter your password"
            self.textPassword.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var botton: UIButton! {
        didSet {
            self.botton.backgroundColor = UIColor(named: "ButtonColor")
            self.botton.setTitle("Login", for: .normal)
            self.botton.setTitleColor(.gray, for: .normal)
            self.botton.layer.cornerRadius = 18
            self.botton.layer.shadowColor = UIColor.black.cgColor
            self.botton.layer.shadowRadius = 18
            self.botton.layer.shadowOpacity = 0.6
            self.botton.addTarget(self,
                                  action: #selector(hold),
                                  for: .touchDown)
            self.botton.addTarget(self,
                                  action: #selector(upRelease),
                                  for: .touchUpInside)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "MyColor")
        
        Utils.getPassword()
    }

    
    // MARK: - Actions
    
    @IBAction func pressButton(_ sender: Any) {
        getSizes()
        
        do {
            try login()
        } catch {
            allert = error.localizedDescription
            
            let allertController = UIAlertController (title: "Ошибка",
                                                      message: allert,
                                                      preferredStyle: .alert)
            
            allertController.addAction(UIAlertAction(title: "OK",
                                                     style: .default,
                                                     handler: nil))
            
            self.present(allertController,
                         animated: true,
                         completion: nil)
        }
    }
    
    
    // MARK: - Methods
    @objc private func hold() {
        self.botton.backgroundColor = .white
    }
    
    @objc private func upRelease() {
        self.botton.backgroundColor = UIColor(named: "ButtonColor")
    }
    
    private func login() throws {
        guard let email = self.textLogin.text else { throw LoginErrors.invalidEmail }
        guard !email.isEmpty else { throw LoginErrors.emptyFieldEmail }
        guard email.contains("@") && email.contains(".") else { throw LoginErrors.invalidEmail }
        guard let UserPassword = self.textPassword.text else { throw LoginErrors.invalidEmail }
        guard !UserPassword.isEmpty else { throw LoginErrors.emptyFieldPassword }
        guard UserPassword == password else { throw LoginErrors.invalidPassword }
        self.imageView.image = UIImage(named: "LoginImage-2")
        print("Success autorised")
    }
    
    private func getSizes() {
        print("Положение и размер View: \(self.myView.frame.debugDescription)")
        print("Положение и размер ImageView относительно View: \(self.imageView.frame.debugDescription)")
        print("Положение и размер ImageView относительно rootView: \(self.imageView.superview?.frame.debugDescription ?? "error")")
        print("Положение и размер TextFieldEmail: \(self.textLogin.frame.debugDescription)")
        print("Положение и размер TextFieldPassword: \(self.textPassword.frame.debugDescription)")
        print("Положение и размер Botton: \(self.botton.frame.debugDescription)")
    }
}

    // MARK: - Extensions

extension LoginErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Неверный формат e-mail!", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Неверный пароль!", comment: "")
        case .emptyFieldEmail:
            return NSLocalizedString("E-mail не введен!", comment: "")
        case .emptyFieldPassword:
            return NSLocalizedString("Пароль не введен!", comment: "")
        }
    }
}
