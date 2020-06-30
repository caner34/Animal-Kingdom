import 'package:flutterapp/Node.dart';

class AnimalLinkedList
{
  Node first;

  AnimalLinkedList(this.first);

  addNode(Node newNode)
  {
    print("node Value and Level: " + newNode.animal.value.toString() + " - level: "+newNode.level.toString());
    if(first == null)
    {
      first = newNode;
    }
    else
    {
      Node crNode = first;
      while(crNode.next != null)
      {
        crNode = crNode.next;
      }
      crNode.next = newNode;
    }
  }

  removeNode(Node exNode)
  {
    print("nodeToBeRemoved: "+exNode.animal.value.toString());
    if(first==null)
    {
      return;
    }
    else if(first == exNode)
    {
      if(first.next == null)
      {
        first = null;
      }
      else
      {
        first = first.next;
      }
    }
    else
    {
      Node crNode = first;
      while (crNode != null)
      {
        if(crNode.next == exNode)
        {
          crNode.next = crNode.next.next;
          break;
        }
        crNode = crNode.next;
      }
    }

    print("list after removal: "+ this.toString());
  }

  AnimalLinkedList getSortedAnimalLinkedListByLevelAndValue()
  {
    print("sorting started...");
    print("before sorting: " + this.toString());

    if(first == null || first.next == null)
    {
      return this;
    }
    Node crNode = first.next;
    Node previousNode = first;
    while(crNode.next != null)
    {
      if(previousNode.level > crNode.level || ((previousNode.level == crNode.level) && (previousNode.animal.value > crNode.animal.value))) {

        putToTheEarliestPositionPossibleInTheChain(previousNode);
        return getSortedAnimalLinkedListByLevelAndValue();
      }
      previousNode = crNode;
      crNode = crNode.next;
    }
    return this;
  }

  int getSize()
  {
    int result = 0;

    Node crNode = first;
    while(crNode != null)
    {
      result++;
      crNode = crNode.next;
    }

    return result;
  }

  @override
  String toString() {
    String result = "";
    Node crNode = first;
    while(crNode != null)
    {
      result += crNode.animal.value.toString() + ", ";
      crNode = crNode.next;
    }
    return result;
  }

  int previousSmallerNodesValue(Node node)
  {
    if(!(first == node && first.next == null))
    {
      Node resultNode = node;
      Node crNode = first;
      while(crNode != null)
      {
        if(resultNode.animal.value == node.animal.value && crNode.animal.value < node.animal.value)
        {
          resultNode = crNode;
        }
        else if(crNode.animal.value > resultNode.animal.value && crNode.animal.value < node.animal.value)
        {
          resultNode = crNode;
        }
        crNode = crNode.next;
      }

      if(resultNode.animal.value >= node.animal.value)
      {
        return 0;
      }
      return resultNode.animal.value;
    }
    return 0;
  }

  int nextLargerNodesValue(Node node)
  {
    if(!(first == node && first.next == null))
    {
      Node resultNode = node;
      Node crNode = first;
      while(crNode != null)
      {
        if(resultNode.animal.value == node.animal.value && crNode.animal.value > node.animal.value)
        {
          resultNode = crNode;
        }
        else if(crNode.animal.value < resultNode.animal.value && crNode.animal.value > node.animal.value)
        {
          resultNode = crNode;
        }
        crNode = crNode.next;
      }

      if(resultNode.animal.value <= node.animal.value)
      {
        return node.animal.value + 1002;
      }
      return resultNode.animal.value;
    }
    return node.animal.value + 1002;
  }

  void putToTheEarliestPositionPossibleInTheChain(Node leastNodeToBeShiftedTowardsTheBeginning)
  {
    removeNode(leastNodeToBeShiftedTowardsTheBeginning);

    Node previousNode = null;
    Node crNode = first;
    if(crNode == null)
    {
      first = leastNodeToBeShiftedTowardsTheBeginning;
    }
    else
    {
      while(crNode != null)
      {
        //print("during putToTheEarliestPositionPossibleInTheChain: "+crNode.animal.value.toString());
        if(leastNodeToBeShiftedTowardsTheBeginning.level < crNode.level || (leastNodeToBeShiftedTowardsTheBeginning.level == crNode.level && leastNodeToBeShiftedTowardsTheBeginning.animal.value < crNode.animal.value))
        {
          if(previousNode != null)
          {
            previousNode.next = leastNodeToBeShiftedTowardsTheBeginning;
          }
          else
          {
            first = leastNodeToBeShiftedTowardsTheBeginning;
          }

          leastNodeToBeShiftedTowardsTheBeginning.next = crNode;
          break;
        }
        previousNode = crNode;
        crNode = crNode.next;
      }

      if(!containsTheNode(leastNodeToBeShiftedTowardsTheBeginning))
      {
        previousNode.next = leastNodeToBeShiftedTowardsTheBeginning;
        leastNodeToBeShiftedTowardsTheBeginning.next = null;
      }
    }
  }

  void multiplyValuesByCoefficient(int coefficient)
  {
    Node crNode = first;
    while (crNode != null)
    {
      crNode.animal.value *= coefficient;
      crNode = crNode.next;
    }
  }

  bool containsTheNode(Node leastNodeToBeShiftedTowardsTheBeginning)
  {
    Node crNode = first;

    while(crNode != null)
    {
      if(crNode == leastNodeToBeShiftedTowardsTheBeginning)
      {
        return true;
      }
      crNode = crNode.next;
    }
    return false;
  }


}