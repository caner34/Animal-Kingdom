import 'package:flutter/cupertino.dart';
import 'package:flutterapp/AnimalLinkedList.dart';

import 'Animal.dart';
import 'Node.dart';

class Tree
{
    Node root;


    Tree(this.root);

    addNodeContinued(Node n, Node enteredNode, Node parent)
    {
      /*int nValue = n.animal.value;
      int enteredNodeValue = -1;
      int parentValue = -1;
      if(enteredNode != null)
      {
        enteredNodeValue = enteredNode.animal.value;
      }
      if(parent != null)
      {
        parentValue = parent.animal.value;
      }

      print("nValue: $nValue >> enteredNodeValue: $enteredNodeValue >> parentValue: $parentValue");
      print("addNodeContinued entered");*/
      if(enteredNode == null)
      {
        if(parent == null)
        {
          //print("both enteredNode and parent null > root assignment");
          root = n;
        }
        else
        {
          if(n.animal.value > parent.animal.value)
          {
            //print("n.animal.value > parent.animal.value >>> $nValue assigned to right of $parentValue");
            parent.rightChild = n;
          }
          else if(n.animal.value < parent.animal.value)
          {
            //print("n.animal.value < parent.animal.value >>> $nValue assigned to left of $parentValue");
            parent.leftChild = n;
          }
        }
      }
      else if(n.animal.value > enteredNode.animal.value)
      {
        //print("n.animal.value > enteredNode.animal.value >>> Go To parent.rightChild");
        addNodeContinued(n, enteredNode.rightChild, enteredNode);
      }
      else if(n.animal.value < enteredNode.animal.value)
      {
        //print("n.animal.value < enteredNode.animal.value >>> Go To parent.leftChild");
        addNodeContinued(n, enteredNode.leftChild, enteredNode);
      }
    }


    addNode(Node n)
    {
      addNodeContinued(n, root, null);
      /*if(root==null)
      {
        root = n;
      }
      else
      {
        addNodeContinued(n, root, null);
      }*/
    }

    static Tree createTree(Tree t, AnimalLinkedList linkedList)
    {
      if(t == null)
      {
        t = Tree(null);

        Node crNode = linkedList.first;
        while(crNode != null)
        {
          print("during createTree crNode.animal.value.toString(): "+crNode.animal.value.toString());
          if(crNode.question.isNotEmpty)
          {
            Animal.addEmptyAnimal(crNode.question, crNode.animal.value, t, crNode.level);
          }
          else if(crNode.animal.name.isNotEmpty)
          {
            Animal.addAnimal(crNode.question, crNode.animal.value, t, crNode.level, crNode.animal.name);
          }

          crNode = crNode.next;
        }

        /*
        //Level 0
        Animal.addEmptyAnimal("Does the animal has legs?", 50, t, 0);

        //Level 1
        Animal.addEmptyAnimal("Does it chew grass?", 25, t, 1);
        Animal.addEmptyAnimal("Does it live underground?", 75, t, 1);

        //Level 2
        Animal.addEmptyAnimal("Does it bark?", 37, t, 2);
        Animal.addEmptyAnimal("Does it live underwater?", 105, t, 2);

        //Level 3
        Animal.addEmptyAnimal("Does it have feathers?", 43, t, 3);
        Animal.addEmptyAnimal("Does it jump?", 90, t, 3);

        //Level 4
        Animal.addEmptyAnimal("Does it fly?", 40, t, 4);
        Animal.addEmptyAnimal("Does it have a lot of sharp teeth?", 97, t, 4);

        //Level 5
        Animal.addEmptyAnimal("Does it skin itself?", 101, t, 5);
        Animal.addAnimal("", 41, t, 5, "Chicken");

        //Level 6
        Animal.addAnimal("", 103, t, 6, "Whale");

        //Level 7*/
      }


      return t;
    }


    Node getNodeByOnlyValue(int value)
    {
      return getNodeByValue(value, this.root);
    }

    Node getNodeByValue(int value, Node n)
    {
      print ("getNodeByValue entered");
      if(n == null)
      {
        print ("n == null");
        return null;
      }

      if(n.animal.value == value)
      {
        int i = n.animal.value;
        print ("n.animal.value == value: $i");
        return n;
      }
      else if(n.animal.value > value)
      {
        int i = n.animal.value;
        print ("n.animal.value $i > value $value");
        return getNodeByValue(value, n.leftChild);
      }
      else if(n.animal.value < value)
      {
        int i = n.animal.value;
        print ("n.animal.value $i < value $value");
        return getNodeByValue(value, n.rightChild);
      }
      else
      {
        return null;
      }
    }

    bool enlargeTreeWithNewQuestionAndAnimal(AnimalLinkedList animalLinkedList, Node incorrectlyGuessedAnimalNode, String newAnimalName, String newQuestion)
    {
      int previousNodesValue = animalLinkedList.previousSmallerNodesValue(incorrectlyGuessedAnimalNode);
      int nextNodesValue = animalLinkedList.nextLargerNodesValue(incorrectlyGuessedAnimalNode);
      int parentQuestionNodeValue = incorrectlyGuessedAnimalNode.animal.value;

      int questionLeftChildValue = ((previousNodesValue + parentQuestionNodeValue) / 2).round();
      int questionRightChildValue = ((nextNodesValue + parentQuestionNodeValue) / 2).round();

      print("previousNodesValue: "+previousNodesValue.toString());
      print("nextNodesValue: "+nextNodesValue.toString());
      print("parentQuestionNodeValue chicken: "+parentQuestionNodeValue.toString());
      print("questionLeftChildValue: "+questionLeftChildValue.toString());
      print("questionRightChildValue: "+questionRightChildValue.toString());

      if( !( (questionLeftChildValue > previousNodesValue && questionLeftChildValue < parentQuestionNodeValue)
          && (questionRightChildValue > parentQuestionNodeValue && questionRightChildValue < nextNodesValue) ) )
      {
        animalLinkedList.multiplyValuesByCoefficient(3);
        return enlargeTreeWithNewQuestionAndAnimal(animalLinkedList, incorrectlyGuessedAnimalNode, newAnimalName, newQuestion);
      }


      Node grandParent = getParent(incorrectlyGuessedAnimalNode);
      Node newAnimalNode = Node("", Animal(questionLeftChildValue, newAnimalName), grandParent.level + 2, null, null);
      incorrectlyGuessedAnimalNode.level++;
      incorrectlyGuessedAnimalNode.animal.value = questionRightChildValue;

      Node parentQuestionNode = Node(newQuestion, Animal(parentQuestionNodeValue, ""), incorrectlyGuessedAnimalNode.level - 1, newAnimalNode, incorrectlyGuessedAnimalNode);

      animalLinkedList.addNode(parentQuestionNode);
      animalLinkedList.addNode(newAnimalNode);

      if(parentQuestionNode.animal.value > grandParent.animal.value)
      {
        grandParent.rightChild = parentQuestionNode;
      }
      else if(parentQuestionNode.animal.value < grandParent.animal.value)
      {
        grandParent.leftChild = parentQuestionNode;
      }

      return true;
    }


  Node getParent(Node child)
  {
    if(child == root)
    {
      return null;
    }
    else
    {
      Node crNode = root;
      while(crNode != null)
      {
        print ("searching parent of "+ child.animal.value.toString() +" >>> crNode.animal.value: "+crNode.animal.value.toString());
        if( ( crNode.leftChild != null && crNode.leftChild.animal.value == child.animal.value )
            || ( crNode.rightChild != null && crNode.rightChild.animal.value == child.animal.value ) )
        {
          return crNode;
        }
        else if(child.animal.value < crNode.animal.value)
        {
          crNode = crNode.leftChild;
        }
        else if(child.animal.value > crNode.animal.value)
        {
          crNode = crNode.rightChild;
        }
      }
      return null;
    }
  }

    preOrderTraversal()
    {
      print("\n\nvar animalInfoArray = [\n");
      traverseFromGivenNode(root);
      print("  ];");
      print("\n DELETE the COMMA from the last element in the animalInfoArray ");
    }

    traverseFromGivenNode(Node node)
    {
      if(node != null)
      {
        print(node.toString());
        traverseFromGivenNode(node.leftChild);
        traverseFromGivenNode(node.rightChild);
      }
    }

}