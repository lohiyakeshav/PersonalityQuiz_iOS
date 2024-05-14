//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Batch-2 on 15/04/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
   
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var singleButtonOne: UIButton!
    @IBOutlet weak var singleButtonTwo: UIButton!
    @IBOutlet weak var singleButtonThree: UIButton!
    @IBOutlet weak var singleButtonFour: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet weak var multiButtonOne: UILabel!
    @IBOutlet weak var multiButtonTwo: UILabel!
    @IBOutlet weak var multiButtonThree: UILabel!
    @IBOutlet weak var multiButtonFour: UILabel!
    
    @IBOutlet weak var multiSwitchOne: UISwitch!
    @IBOutlet weak var multiSwitchTwo: UISwitch!
    @IBOutlet weak var multiSwitchThree: UISwitch!
    @IBOutlet weak var multiSwitchFour: UISwitch!
    
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedLabelOne: UILabel!
    @IBOutlet weak var rangedLabelTwo: UILabel!
    
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    
    var questions: [Question] = [
        Question(
            text: "Which food do you like the most?",
            type:.single,
            answers: [
                Answer(text: "Steak", type: .lion),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .bunny),
                Answer(text: "Corn", type: .turtle)
            ]
        ),
        Question(
            text: "Which activities do you enjoy?",
            type:.multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .bunny),
                Answer(text: "Eating", type: .lion)
               ]
        ),
        Question(
            text: "How much do you enjoy car rides?",
            type:.ranged,
            answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .bunny),
                Answer(text: "U barely notice them", type: .turtle),
                Answer(text: "I love them", type: .lion)
              ]
        ),
    ]
        
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
                
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
               
               switch currentQuestion.type {
               case .single:
                   updateSingleStack(using: currentAnswers)
               case .multiple:
                   updateMultipleStack(using: currentAnswers)
               case .ranged:
                   updateRangedStack(using: currentAnswers)
               }
    }
    
    
      func updateSingleStack(using answers: [Answer]) {
           singleStackView.isHidden = false
           singleButtonOne.setTitle(answers[0].text, for: .normal)
           singleButtonTwo.setTitle(answers[1].text, for: .normal)
           singleButtonThree.setTitle(answers[2].text, for: .normal)
           singleButtonFour.setTitle(answers[3].text, for: .normal)
       }
       
       func updateMultipleStack(using answers: [Answer]) {
           multipleStackView.isHidden = false
           multiSwitchOne.isOn = false
           multiSwitchTwo.isOn = false
           multiSwitchThree.isOn = false
           multiSwitchFour.isOn = false
           
           
           multiButtonOne.text = answers[0].text
           multiButtonTwo.text = answers[1].text
           multiButtonThree.text = answers[2].text
           multiButtonFour.text = answers[3].text
       }
       
       func updateRangedStack(using answers: [Answer]) {
           rangedStackView.isHidden = false
           rangedSlider.setValue(0.5, animated: false)
           rangedLabelOne.text = answers.first?.text
           rangedLabelTwo.text = answers.last?.text
           
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    
    
    var answersChosen : [Answer] = []
    
    
    
    @IBAction func singleButtonTapped(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case singleButtonOne:
            answersChosen.append(currentAnswers[0])
        case singleButtonTwo:
            answersChosen.append(currentAnswers[1])
        case singleButtonThree:
            answersChosen.append(currentAnswers[2])
        case singleButtonFour:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    var questionIndex = 0
    
    
    func nextQuestion(){
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        if  multiSwitchOne.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if  multiSwitchTwo.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if  multiSwitchThree.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if  multiSwitchFour.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
        
    }
    
    
    
    @IBAction func rangeAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
                        
        answersChosen.append(currentAnswers[index])
        nextQuestion()
        
    }
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
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
