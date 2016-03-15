//
//  ViewController.swift
//  Tic Tac Toe App
//
//  Created by user116633 on 3/14/16.
//  Copyright © 2016 user116633. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // -----------------------------------------------------------------------------
    // ---------------------------- PART 1 - BASE FUNCTIONALITY --------------------
    // -----------------------------------------------------------------------------
    
    // 1 = circles, 2 = crosses
    var player1 = 1
    
    // Create an Array to store Game State - 9 Spots
    var gameStatus = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    //WINNER - Sequence Combinations
    let winner = [[0, 1, 2], [3, 4, 5], [6, 7, 8], //Horizontal Winning Combos
                  [0, 3, 6], [1, 4, 7], [2, 5, 8], //Diagonal Combos
                  [0, 4, 8], [2, 4, 6]] // Vertical Winning Combos
    
    //Create A Button For Playing Again
    @IBOutlet weak var playAgain: UIButton!
    
    //Create The Action For Playing Again
    @IBAction func playAgainPress(sender: AnyObject)
    {
        //Set the Game State Back To Zero
        gameStatus = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        //Set The Player Status Back to Initial
        player1 = 1
        //Reset the Game 
        gameActive = true
        
        //Hide The Label Initially
        gameOver.hidden = true
        //Center The Label
        gameOver.center = CGPointMake(gameOver.center.x - 500, gameOver.center.y)
        
        //Hide The Label Initially
        playAgain.hidden = true
        //Center The Label
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
        
        //Reset all Images and Board
        var clear : UIButton
        
        //Loop through each tag in array
        for var i = 0; i < 9; i++
        {
            //Clear the view with each tag
            clear = view.viewWithTag(i) as! UIButton
            //Update the board image to inital state
            clear.setImage(nil, forState: .Normal)
        }
    }
    
    //Create a clickable button
    @IBOutlet weak var button: UIButton!
    
    //Game over label
    @IBOutlet var gameOver: UILabel!
    
    //Check if game is active
    var gameActive = true
    
    
    //Action when button is pressed
    @IBAction func pressButton(sender: AnyObject)
    {
        //Retrieve Button Position Using Tags
        if(gameStatus[sender.tag] == 0 && gameActive == true)
        {
            //Update The Game State Based on Tag
            gameStatus[sender.tag] = player1
            
            if player1 == 1
            {
                //Set the player to circles
                sender.setImage(UIImage(named: "mycircle.png"), forState: .Normal)
            
                //Set the player to crosses
                player1 = 2
            }
            else
            {
                //Set the player to crosses
                sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
            
                //Set the player back to circles
                player1 = 1
            }
            
            // -----------------------------------------------------------------------------
            // ------------------------- PART 2 - LOGIC & CONFIGURATION --------------------
            // -----------------------------------------------------------------------------
            
            for combination in winner
            {
                //Check Each Position and Game State For A Horizontal Win At Top -- All Circles or Crosses
                if(gameStatus[combination[0]] != 0 && gameStatus[combination[0]] == gameStatus[combination[1]]
                    && gameStatus[combination[1]] == gameStatus[combination[2]])
                {
                    
                    //Deactivate Game
                    gameActive = false
                    
                    //Print The Winner
                    if gameStatus[combination[0]] == 1
                    {
                        //Render The Label Text
                        gameOver.text = "Circles Have Won!"
                    }
                    else
                    {
                        //Render The Label Text
                        gameOver.text = "Crosses Have Won!"
                    }
                    
                    //Call this function
                    finishGame()
                }
            }
            
            if gameActive == true
            {
            
                //Set Game Active to False
                gameActive = false
            
                //At This Point, The Game Has Tied
                for buttonState in gameStatus
                {
                    if buttonState == 0
                    {
                        gameActive = true
                    }
                }
            
                if gameActive == false
                {
                    gameOver.text = "It is a DRAW!"
                    finishGame()
                }
            }
        }
    }
    
    //This function resets label and button
    func finishGame()
    {
        //Display The Game Over Label
        gameOver.hidden = false
        //Display The Replay Button
        playAgain.hidden = false
        
        //Animate The Labels
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            //Display The Animated Game Over Label
            self.gameOver.center = CGPointMake(self.gameOver.center.x + 500, self.gameOver.center.y)
            //Display The Animated Play Again Label
            self.playAgain.center = CGPointMake(self.playAgain.center.x + 500, self.playAgain.center.y)
            
        })
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        //Hide The Label Initially
        gameOver.hidden = true
        //Center The Label
        gameOver.center = CGPointMake(gameOver.center.x - 500, gameOver.center.y)
        
        //Hide The Label Initially
        playAgain.hidden = true
        //Center The Label
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

