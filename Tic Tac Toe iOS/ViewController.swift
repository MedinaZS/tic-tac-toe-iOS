//
//  ViewController.swift
//  Tic Tac Toe iOS
//
//  Created by Montserrat Medina on 2023-08-14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    enum Turn: String {
        case X, O
    }
    
    var firstTurn : Turn = .X
    var currentTurn : Turn = .X
    var attemps = 0
    let CRUZ = Turn.X.rawValue
    let CERO = Turn.O.rawValue
    var countWinX = 0
    var countWinO = 0
    
    var winPosibilities : [[Int]] = [
        //Horizontal
        [0,1,2],
        [3,4,5],
        [6,7,8],
        //Vertical
        [0,3,6],
        [1,4,7],
        [2,5,8],
        //Diagonal
        [0,4,8],
        [2,4,6],
        
    ]
    
    var board: [UIButton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Añadir los botones al array
        board.append(button1)
        board.append(button2)
        board.append(button3)
        board.append(button4)
        board.append(button5)
        board.append(button6)
        board.append(button7)
        board.append(button8)
        board.append(button9)
    }
    
    @IBAction func clickBoard(_ sender: UIButton) {
        
        
        //Si esta vacio (nil) se puede hacer jugada
        if sender.title(for: .normal) == nil {
            if currentTurn == .X {
                sender.setTitle(CRUZ , for: .normal)
                currentTurn = .O
            } else {
                sender.setTitle(CERO, for: .normal)
                currentTurn = .X
            }
            attemps+=1
            
            turnLabel.text = "Turn \(currentTurn)"
            
            //Verificar ganador
            if attemps >= 3 {
                if !checkWinner() && attemps == 9 {
                    showAlert(title: "It's a tie :(")
                }
            }
        }
    }
    
    func checkWinner() -> Bool {
        for posibility in winPosibilities{
            let b1 = board[posibility[0]].title(for: .normal)
            let b2 = board[posibility[1]].title(for: .normal)
            let b3 = board[posibility[2]].title(for: .normal)
            
            if b1 == CRUZ && b2 == CRUZ && b3 == CRUZ {
                countWinX += 1
                showAlert(title: "X Win!! ")
                return true
            }else if b1 == CERO && b2 == CERO && b3 == CERO {
                countWinO += 1
                showAlert(title: "O Win!! ")
                return true
            }
        }
        return false
    }
    
    func playAgain(){
        for button in board {
            button.setTitle(nil, for: .normal)
        }
        attemps = 0
        
        print("First turn \(firstTurn)")
        
        if firstTurn == Turn.X {
            firstTurn = .O
            currentTurn = .O
        }else if firstTurn == Turn.O {
            firstTurn = .X
            currentTurn = .X
        }
        
        turnLabel.text = "Turn \(currentTurn)"
    }
    
    func startOver(){
        playAgain()
        firstTurn = .X
        currentTurn = .X
        countWinO = 0
        countWinX = 0
    }
    
    func showAlert(title : String){
        let message = "\nX score: \(countWinX) \nO score: \(countWinO)"
        
        //Style can be actionSheet o modal
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        
        //Agregar boton de reseteo
        alert.addAction(UIAlertAction(title: "Start Over", style: .destructive, handler: { (_) in self.startOver()
        }))
        alert.addAction(UIAlertAction(title: "Play Again", style: .cancel, handler: { (_) in self.playAgain()
        }))
        
        
        self.present(alert, animated: true)
    }
    
}

