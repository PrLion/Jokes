//
//  CreateJokeViewController.swift
//  Jokes
//
//  Created by mac on 15.09.2020.
//  Copyright © 2020 prlion. All rights reserved.
//

import UIKit
import PromiseKit

class CreateJokeViewController: UIViewController {
    
    var crud: CRUDService<JokeCRUDModel> = crudService()
    var joke: JokeCRUDModel?
    
    var saveClosure: () -> Void = {}
    // MARK: - Outlets
    
    @IBOutlet private var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet private var textView: UITextView! {
        didSet {
            textView.delegate = self
            textView.text = "Write your joke"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var saveButton: UIButton!
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "CreateJokeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.addAction(for: .touchUpInside, action: { _ in self.dismiss(animated: true, completion: nil) })
        saveButton.addAction(for: .touchUpInside, action: { _ in self.save() })
    }
    
    // MARK: - Action
    
    private func save() {
        if textView.text != "Write your joke" {
            joke = JokeCRUDModel(with: .init(context: .init(concurrencyType: .privateQueueConcurrencyType)))
            joke?.isMy = true
            joke?.joke = textView.text
            joke?.isLike = true
            
            firstly {
                crud.read()
            }.compactMap {
                self.joke?.id = Int32($0.count + 1)
            }.then {
                self.crud.create([self.joke!])
            }.done {
                self.dismiss(animated: true, completion: nil)
                self.saveClosure()
            }.catch {
                print($0)
            }
        }
    }
}

extension CreateJokeViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            textView.text = "Write your joke"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        } else {
            return true
        }
        
        return false
    }
}
