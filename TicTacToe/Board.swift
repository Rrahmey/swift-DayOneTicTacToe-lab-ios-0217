//
//  Board.swift
//  TicTacToe
//
//  Created by Jim Campagno on 2/5/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

protocol BoardDelegate: class {
    func playerTurn(board: Board, position: Int) -> Player
}


class Board: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var zeroImageView: UIImageView!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var twoImageView: UIImageView!
    
    @IBOutlet weak var threeImageView: UIImageView!
    @IBOutlet weak var fourImageView: UIImageView!
    @IBOutlet weak var fiveImageView: UIImageView!
    
    @IBOutlet weak var sixImageView: UIImageView!
    @IBOutlet weak var sevenImageView: UIImageView!
    @IBOutlet weak var eightImageView: UIImageView!
    
    var position: Int!
    var winner: Player!
    var winningView: UIView!
    
    weak var delegate: BoardDelegate!
    
    var all: [UIImageView] {
        return [zeroImageView, oneImageView, twoImageView, threeImageView, fourImageView, fiveImageView, sixImageView, sevenImageView, eightImageView]
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("Board", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.constrainEdges(to: self)
        setupImages()
    }
    
}

// MARK: - Setup
extension Board {
    
    func setupImages() {
        var tag = 0
        for imageView in all {
            imageView.tag = tag
            tag += 1
           imageView.image = nil
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(playTurn))
            gestureRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
}

// MARK: - Player Turn
extension Board {
    
    func playTurn(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let player = delegate.playerTurn(board: self, position: imageView.tag)
        imageView.removeGestureRecognizer(sender)
        animateTurn(imageView: imageView, player: player)
    }
    
    func animateTurn(imageView: UIImageView, player: Player) {
        imageView.alpha = 0.0
        imageView.image = player.image
        UIView.animate(withDuration: 0.1, animations: {
            imageView.alpha = 1.0
        })
    }
    
}

// MARK: - Winner
extension Board {
    
    func win(for player: Player) {
        winningView = UIView(frame: frame)
        winningView.backgroundColor = UIColor.clear
        winningView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(winningView, belowSubview: contentView)
        //insertSubview(winningView, aboveSubview: contentView)
        winningView.constrainEdges(to: self)
        winningView.layer.cornerRadius = 8.0
        winningView.layer.masksToBounds = true
        
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        winningView.addSubview(imageView)
        imageView.constrainEdges(to: winningView)
        imageView.image = player.image
        
        UIView.transition(from: contentView, to: winningView, duration: 0.2, options: .transitionFlipFromLeft, completion: nil)
        
        
    }
    
    func resetBoardBigWin() {
        //UIView.transition(from: winningView, to: contentView, duration: 0.2, options: .transitionFlipFromLeft, completion: nil)
        
        commonInit()
        self.winningView.alpha = 0.0
       // self.winningView.isHidden = true

    }
}


extension UIView {
    
    func constrainEdges(to view: UIView) {
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}
