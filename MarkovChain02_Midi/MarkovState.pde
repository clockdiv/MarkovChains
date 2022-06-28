
class MarkovState 
{
  int id;                // this state's identifier. here, it's the Midi-Note; could also be a name for the state
  FloatList transitions;   // all transitions to all states
  
  MarkovState(int _id, FloatList _transitions) 
  {
    id = _id;
    transitions = _transitions;
  }
  
  int getNextState(float chance)
  {
    int nextstateIndex = -1;
    float prevTransition = 0, thisTransition;
    for (int i = 0; i < transitions.size() ; i++)
    {      
      thisTransition = prevTransition + transitions.get(i);
      
      if (chance >= prevTransition && chance < thisTransition){
        //println("-->> it is!");
        nextstateIndex = i;
        break;
      }
      prevTransition = thisTransition;
      
    }
    return nextstateIndex;
  }
  
}
