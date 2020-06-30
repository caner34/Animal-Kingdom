import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

import 'Boolean.dart';
import 'CustomButton.dart';
import 'Node.dart';
import 'Tree.dart';

class Game
{
  CustomButton customButtonStartGame;
  String message;
  Node parentNode;
  Node crNode;
  Tree tree;
  Function callbackSetMessage, callbackActivateImageAndSound, callbackSetImageAssetName, callbackStartSound, callbackStartNewGame, callbackNoNewGame, callbackActivateTextField;
  bool isAnimalGuessed;
  Boolean lastIsToProceedLeft;
  bool isTheUserAskedForHelpForImprovement;
  bool isTheAnimalGuessedCorrectly;
  Boolean isTheUserToHelpImprovement;

  static String CONS_ANIMAL_GUESS_SENTENCE_START = "Is the animal in your mind ";
  static String CONS_ANIMAL_GUESS_SENTENCE_END = "?";

  static String CONS_ANIMAL_GUESS_SUCCESSFUL = "The animal is guessed successfully!\nWould you like to start a new Game?";
  static String CONS_WOULD_YOU_LIKE_A_NEW_GAME = "Would you like to start a new Game?";
  static String CONS_THANKS_FOR_PLAYING = "Thanks for Playing!";
  static String CONS_ANIMAL_GUESS_FAILED = "OH NO! Would you like to help us improve the app?";


  static String CONS_WHAT_WAS_THE_ANIMAL_IN_YOUR_MIND = "What was the animal in your mind?";

  String guessedAnimal = "";
  int guessedAnimalValue = -1;
  String correctAnimal = "";


  Game(this.customButtonStartGame, this.message, this.parentNode, this.crNode, this.tree, this.callbackSetMessage, this.callbackActivateImageAndSound, this.callbackSetImageAssetName, this.callbackStartSound, this.callbackStartNewGame, this.callbackNoNewGame, this.callbackActivateTextField, [this.isAnimalGuessed = false, this.lastIsToProceedLeft = null, this.isTheUserAskedForHelpForImprovement = false, this.isTheAnimalGuessedCorrectly = false, this.isTheUserToHelpImprovement = null]);

  proceedGame(Boolean isToProceedLeft)
  {
    print("proceedGame();");

    if(isAnimalGuessed)
    {
      print("isAnimalGuessed");


      if(isTheUserToHelpImprovement != null && isTheUserToHelpImprovement.value)
      {
        return;
      }

      if(isTheAnimalGuessedCorrectly)
      {
        print("isTheAnimalGuessedCorrectly");
        if(isToProceedLeft.value)
        {
          print("isTheAnimalGuessedCorrectly And New Game");
          callbackStartNewGame();
        }
        else
        {
          callbackSetMessage(CONS_THANKS_FOR_PLAYING);
          callbackActivateImageAndSound("Thanks");
          callbackNoNewGame();
          tree.preOrderTraversal();
        }
        return;
      }

      if(isTheUserAskedForHelpForImprovement)
      {
        if(isToProceedLeft.value)
        {
          isTheUserToHelpImprovement = Boolean(true);
          String improvementQuestion = guessedAnimalValue.toString();
          callbackSetMessage(improvementQuestion);
          callbackActivateTextField();
        }
        else
        {
          callbackSetMessage(CONS_THANKS_FOR_PLAYING);
          callbackActivateImageAndSound("Thanks");
          callbackNoNewGame();
        }
        return;
      }

      if(isToProceedLeft.value)
      {
        isTheAnimalGuessedCorrectly = true;
        callbackSetMessage(CONS_ANIMAL_GUESS_SUCCESSFUL);
        callbackStartSound("Correct");
      }
      else
      {
        isTheUserAskedForHelpForImprovement = true;
        callbackSetMessage(CONS_ANIMAL_GUESS_FAILED);
        callbackStartSound("Oh No");
      }
      return;
    }


    setCrNode(isToProceedLeft);

    if(crNode == null)
    {
      String directionStr = "left";
      if(!isToProceedLeft.value)
      {
        directionStr = "right";
      }

      callbackSetMessage("No " + directionStr + " child for the node with the following question:\n\""+parentNode.question+"\"");
      return;
    }


    if(crNode.question.isNotEmpty)
    {
      callbackSetMessage(crNode.question);
    }
    else
    {
      callbackSetMessage(CONS_ANIMAL_GUESS_SENTENCE_START + crNode.animal.name + CONS_ANIMAL_GUESS_SENTENCE_END);
      guessedAnimal = crNode.animal.name;
      guessedAnimalValue = crNode.animal.value;
      lastIsToProceedLeft = Boolean(isToProceedLeft.value);
      isAnimalGuessed = true;
      callbackActivateImageAndSound(guessedAnimal);
    }
  }

  void setCrNode(Boolean isToProceedLeft)
  {
    if(isToProceedLeft == null)
    {
      crNode = tree.root;
    }
    else if(isToProceedLeft.value)
    {
      parentNode = crNode;
      crNode = crNode.leftChild;
    }
    else if(!isToProceedLeft.value)
    {
      parentNode = crNode;
      crNode = crNode.rightChild;
    }
  }

  //Game(this.customButtonStartGame);


}

