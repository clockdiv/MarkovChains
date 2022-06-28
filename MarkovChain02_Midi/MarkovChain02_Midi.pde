// how to parse a Midi File is discussed here:
// https://discourse.processing.org/t/parse-midi-files/14126/2
// https://docs.oracle.com/javase/tutorial/sound/overview-MIDI.html

// Beethoven Sonatas as Midi Files can be found here:
// https://www.kunstderfuge.com/beethoven/sonatas.htm

import javax.sound.midi.*;

ArrayList<MarkovState> states = new ArrayList<MarkovState>();;
MarkovState currentState;
IntList trainingData = new IntList();  // the notes of the song is put in here, but without length or rhythm 
IntList markovData = new IntList();    // the notes that the Markov Chain created

void setup()
{
  String filenameOriginal = sketchPath() + "/data/sonate_01_(c)hisamori.mid";
  String filenameBadCopy  = sketchPath() + "/data/sonate_01_(c)hisamori_BadCopy.mid";
  String filenameMarkov   = sketchPath() + "/data/sonate_01_(c)hisamori_Markov.mid";
  
  // Read training data from MIDI File:
  trainingData = MidiFileWrapper.readMidiFile(filenameOriginal, 1);
  
  // "BadCopy":
  // As the original MIDI File has all the timing and rhythmic information that we don't take,
  // let's first create a new MIDI File that is the same as the original but with only the
  // notes and no rhythm
  MidiFileWrapper.writeMidiFile(trainingData, filenameBadCopy);
  
  // Initialize the Chain with equal data:
  initMarkovChain();
  
  // Train the Chain with trainingData:
  for(int i = 0; i < 5; i++)
  {
    //printStatesInTrainingData();
    trainMarkovChain();
  }
  
  //printStatesInTrainingData();

  currentState = states.get(60);  // select a start state  
  
  run(40); // parameter = chain length, e.g. 40 notes
  
  MidiFileWrapper.writeMidiFile(markovData, filenameMarkov);
  
  exit();
}

void initMarkovChain()
{
  // initialize 128 states with 128 transitions each
  for(int i = 0; i < 128; i++)
  {
    FloatList transitions = new FloatList();
    for(int j = 0; j < 128; j++) {
      transitions.append(1.0/128.0);
    }
    states.add(new MarkovState(i, transitions));
  }
}



void trainMarkovChain()
{
  float k = 0.1; // the factor how hard the training-data is changed in each training-loop
  for(int i = 0; i < trainingData.size() - 1; i++)
  {
    int thisNote = trainingData.get(i);
    int nextNote = trainingData.get(i + 1); 
    
    MarkovState trainingState = states.get(thisNote);
    
    float n = trainingState.transitions.size(); // number of states
    for (int j = 0; j < n; j++)
    {
      float currentChance = trainingState.transitions.get(j);
      float newChance;
      if(j == nextNote) {
        newChance = constrain(currentChance + k, 0, 1);  // increase chance for this note
      }
      else {
        newChance = constrain(currentChance - k/(n-1), 0, 1);  // decrease chance for this note
      }
      trainingState.transitions.set(j, newChance);
    }
  }
}


void run(int n)
{
  // run Markov Chain
  for(int i = 0; i < n; i++)
  {
    //println("---------------");
    //println("--- NOTE", nf(i, 2), "---");
    //println("---------------");
    //println("current state:", currentState.id);
    markovData.append(currentState.id);
    float chance = random(1.0);
    //println("chance =", nf(chance, 1, 2));
    
    currentState = states.get(currentState.getNextState(chance));
  }
  print("finale state:", currentState.id);  
}










void printAllStatesData()
{
  for(int i = 0; i < states.size(); i++) 
  {
    println();
    println(i);
    for(int j = 0; j < states.get(i).transitions.size(); j++)
    {
      print(states.get(i).transitions.get(j), ", ");
    }
    println();
  }  
}

void printStatesInTrainingData()
{
  println("States in Training");
  println("==================");
  for(int i = 0; i < trainingData.size(); i++) 
  {
    println();
    int stateIndex = trainingData.get(i);
    println("#", i, "Note:", stateIndex);
    float p = 0;
    MarkovState currentState = states.get(stateIndex); // that's the state we want to show
    for(int j = 0; j < currentState.transitions.size(); j++) // ..and from that state we want to see all transistions
    {
      print(nf(j,3,0), currentState.transitions.get(j), "\t");
      p += currentState.transitions.get(j);
      if((j+1)%5==0)println();
    }
    println();
    println("p: ", p);
  }  
  println("==================");
  println();
}
