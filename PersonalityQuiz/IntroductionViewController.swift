//
//  ViewController.swift
//  PersonalityQuiz
//
//  Created by Batch-2 on 15/04/24.
//

import UIKit

class IntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    @IBAction func beginQuizPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "questionSeque", sender: nil)
    }
    
    
    
    
    
    
    
    
}

