// The Java Sound and Midi Library:
// https://docs.oracle.com/javase/tutorial/sound/index.html

// Reference to javax.sound.midi classes:
// https://docs.oracle.com/javase/8/docs/api/index.html

// Main classes are:
// javax.sound.midi.MidiSystem
// javax.sound.midi.Sequence
// javax.sound.midi.Track
// javax.sound.midi.ShortMessage

import javax.sound.midi.*;

void setup()
{
  // Example of reading a midi file and printing it's information
  MidiFileWrapper.readMidiFile(sketchPath() + "/data/sonate_01_partShort.mid");

  // Example of writing for notes to a midi file (without timing-, length- or any other information)
  IntList noteList = new IntList(60, 65, 63, 72);
  MidiFileWrapper.writeMidiFile(noteList, sketchPath() + "/data/test.mid");

  // end the programm
  exit();
}
