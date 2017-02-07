//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jim Campagno on 2/5/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BoardDelegate {
    
    @IBOutlet weak var boardZero: Board!
    @IBOutlet weak var boardOne: Board!
    @IBOutlet weak var boardTwo: Board!
    
    @IBOutlet weak var boardThree: Board!
    @IBOutlet weak var boardFour: Board!
    @IBOutlet weak var boardFive: Board!
    
    @IBOutlet weak var boardSix: Board!
    @IBOutlet weak var boardSeven: Board!
    @IBOutlet weak var boardEight: Board!
  
    
    var allBoards: [Board] {
        return [boardZero, boardOne, boardTwo, boardThree, boardFour, boardFive, boardSix, boardSeven, boardEight]
    }
    
    
    
    
    
    var previousMove: Player = .o
    var currentMove: Player = .x
    
    var xMoves: [Int:[Int]] = [0:[], 1:[], 2:[], 3:[], 4:[], 5:[], 6:[], 7:[], 8:[]]
    var oMoves: [Int:[Int]] = [0:[], 1:[], 2:[], 3:[], 4:[], 5:[], 6:[], 7:[], 8:[]]
    var bigBoard: [Player:[Int]] = [.x:[], .o:[]]
    var humanMove: (Int,Int) = (0,0)
    
    var possibleMoves: [(Int,Int)] = [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(1,0),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(3,0),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(4,0),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(5,0),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(6,0),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(7,0),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(8,0),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        var boardPosition = 0
        for board in allBoards {
            board.position = boardPosition
            board.delegate = self
            boardPosition += 1
        }
    }
    
    func computerPlayer () {
        let index: Int = Int(arc4random_uniform(UInt32(possibleMoves.count)))
        let randomMove = (possibleMoves[index])
        possibleMoves.remove(at: index)
        print("computer")
        print(possibleMoves)
        print("The random move is \(randomMove)")
        playerTurn(board: allBoards[randomMove.0], position: randomMove.1)
        
        
    }
    
    func checkForWin(for player: Player, currentBoard: Int, position: [Int]) {
        let winningBoard: Board = allBoards[currentBoard]
        if position.contains(0) && position.contains(6) && position.contains(3) {
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        } else if position.contains(0) && position.contains(1) && position.contains(2){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(2) && position.contains(5) && position.contains(8){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(6) && position.contains(7) && position.contains(8){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(0) && position.contains(4) && position.contains(8){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(2) && position.contains(4) && position.contains(6){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(1) && position.contains(4) && position.contains(7){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }else if position.contains(3) && position.contains(4) && position.contains(5){
            winningBoard.win(for: player)
            bigBoard[player]!.append(currentBoard)
            checkForBigWin(player: player)
        }
    }
    
    func playerTurn(board: Board, position: Int) -> Player {
        switch previousMove {
        case .o:
            currentMove = .x
            
        case .x:
            currentMove = .o
            
        }
        
        previousMove = currentMove
        
            switch currentMove {
        case .o:
            oMoves[board.position]!.append(position)
            computerPlayer()
            checkForWin(for: .o, currentBoard: board.position, position: oMoves[board.position]!)
        case .x:
            xMoves[board.position]!.append(position)
            humanMove = (board.position, position)
            print("The human move is \(humanMove)")
            for (index, numbers) in possibleMoves.enumerated() {
                if numbers == humanMove {
                    possibleMoves.remove(at: index)
                }
            }
            print(possibleMoves)
            checkForWin(for: .x, currentBoard: board.position, position: xMoves[board.position]!)
        }
        
        
        return currentMove
        
    }
    
    
    
    func checkForBigWin(player:Player) {
        for (xOro, bigPosition) in bigBoard {
            if bigPosition.contains(0) && bigPosition.contains(6) && bigPosition.contains(3){
                print("Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(0) && bigPosition.contains(1) && bigPosition.contains(2){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(2) && bigPosition.contains(5) && bigPosition.contains(8){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(6) && bigPosition.contains(7) && bigPosition.contains(8){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(0) && bigPosition.contains(4) && bigPosition.contains(8){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(2) && bigPosition.contains(4) && bigPosition.contains(6){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(1) && bigPosition.contains(4) && bigPosition.contains(7){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            } else if bigPosition.contains(3) && bigPosition.contains(4) && bigPosition.contains(5){
                print( "Player \(xOro) has won! Congratulations!")
                resetGame()
            }
            
        }
    }
    
    func resetGame() {
        print("reseeting game")
        for board in allBoards{
            //board.setupImages()
            if board.winningView != nil {
                board.resetBoardBigWin()
            }
        }
        
        xMoves = [0:[], 1:[], 2:[], 3:[], 4:[], 5:[], 6:[], 7:[], 8:[]]
        oMoves = [0:[], 1:[], 2:[], 3:[], 4:[], 5:[], 6:[], 7:[], 8:[]]
        bigBoard = [.x:[], .o:[]]

    }
    
 
    
    
    
    
    
    
    
}


