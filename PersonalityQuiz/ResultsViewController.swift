//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Batch-2 on 15/04/24.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    var responses: [Answer]!

    @IBOutlet weak var resultAnswer: UILabel!
    
    
    @IBOutlet weak var resultDefinition: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func calculatePersonalityResult() {
           var frequencyOfAnswers: [AnimalType: Int] = [:]
           let responseTypes = responses.map{ $0.type }
           
           for response in responseTypes {
               frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
           }
           
           let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
           {(pair1, pair2) -> Bool in
               return pair1.value > pair2.value
           })
           
           let mostCommonAnswer = frequentAnswersSorted.first!.key
           
           resultAnswer.text = "You are a \(mostCommonAnswer.rawValue)!"
           resultDefinition.text = mostCommonAnswer.definition
           
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
