
class State 
{
  String name;
  FloatList transitions;
  ArrayList<State> states;
  
  State(ArrayList<State> _states, String _name, FloatList _transitions) 
  {
    name = _name;
    transitions = _transitions;
    states = _states;
  }
  
  State getNextStateIndex(float chance)
  {
    int nextstate = -1;
    float prevTransition = 0, thisTransition;
    for (int i = 0; i < transitions.size() ; i++)
    {      
      thisTransition = prevTransition + transitions.get(i);
      
      println("For state", states.get(i).name, ", chance needs to be between", nf(prevTransition,1,2),"and", nf(thisTransition,1,2));
      if (chance >= prevTransition && chance < thisTransition){
        println("-->> it is!");
        nextstate = i;
        break;
      }
      prevTransition = thisTransition;
      
    }
    return states.get(nextstate);
  }
  
}
