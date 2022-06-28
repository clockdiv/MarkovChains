// basic intro to Markov chains:
// https://towardsdatascience.com/introduction-to-markov-chain-programming-8ddbe0ac1c84

ArrayList<State> states = new ArrayList<State>();;
State currentState, nextState;

void setup()
{
  // Fill Markov Chain with data ("train")
  states.add(new State(states, "Sunny", new FloatList(0.6, 0.3, 0.1)));
  states.add(new State(states, "Rainy", new FloatList(0.5, 0.3, 0.2)));
  states.add(new State(states, "Thunderstorm", new FloatList(0.7, 0.2, 0.1)));
  
  // create a start situation
  currentState = states.get(1);  // that's a Rainy day!
  
  // run Markov Chain
  int n = 25; // run the Markov Chain for n times
  for(int i = 0; i < n; i++)
  {
    println("--------------");
    println("--- DAY", nf(i, 2), "---");
    println("--------------");
    println("currentState:", currentState.name);
    float chance = random(1.0);
    println("chance =", nf(chance, 1, 2));
    
    nextState = currentState.getNextStateIndex(chance);
    
    println("nextState:", nextState.name);
    
    currentState = nextState;
    println();
  }
  print(currentState.name);
  exit();  
}
