static class MidiFileWrapper {

  static IntList readMidiFile(String filename, int trackIndex) {
    IntList noteList = new IntList();
    try {
      File midiFile = new File(filename);
      Sequence sequence = MidiSystem.getSequence(midiFile);

      MidiFileFormat mff = MidiSystem.getMidiFileFormat(midiFile);
      println("MidiFileFormat: Type", mff.getType(), ", DivisionType", mff.getDivisionType(), ", MicrosecondLength", mff.getMicrosecondLength() );

      Track[] tracks = sequence.getTracks();
      Track track = tracks[trackIndex]; // track 0 is sometimes tempo-track only
      //MidiEvent midiEvent = new MidiEvent();
      println("Track Size: ", track.size());

      for (int i = 0; i < track.size(); i++)
      {
        //println("\n====", i, "=========");
        MidiMessage midiMessage =track.get(i).getMessage();
        //println("MidiMessage:", midiMessage);

        if (midiMessage instanceof MetaMessage)
        {
          // MetaMessages explained here:
          // https://www.recordingblogs.com/wiki/midi-meta-messages
          MetaMessage m = (MetaMessage) midiMessage;
          //println("Type:", hex(m.getType()));
          //println("Data:", m.getData());
        } else if (midiMessage instanceof ShortMessage)
        {
          ShortMessage m = (ShortMessage) midiMessage;
          int cmd = m.getCommand();

          if (cmd==ShortMessage.NOTE_ON){
            noteList.append(m.getData1());
          }
          /*
          if (cmd == ShortMessage.NOTE_OFF || cmd == ShortMessage.NOTE_ON) {
            print( (cmd==ShortMessage.NOTE_ON ? "NOTE_ON" : "NOTE_OFF") + "; ");
            print("channel: " + m.getChannel() + "; ");
            print("note: " + m.getData1() + "; ");
            println("velocity: " + m.getData2());
          }
          */
        }
      }
    }
    catch(Exception e)
    {
      println(e);
    }
    return noteList;
  }



  static void writeMidiFile(IntList noteList, String filename) {
    File outFile = new File(filename);
    try {
      Sequence sequence = new Sequence(Sequence.PPQ, 4);

      Track track;
      track = sequence.createTrack();

      ShortMessage shortMessage;

      for (int i = 0; i < noteList.size(); i++) {
        int note = noteList.get(i);
        shortMessage = new ShortMessage(ShortMessage.NOTE_ON, 0, note, 120);
        MidiEvent midiEvent = new MidiEvent(shortMessage, i);
        track.add(midiEvent);

        shortMessage = new ShortMessage(ShortMessage.NOTE_OFF, 0, note, 0);
        midiEvent = new MidiEvent(shortMessage, i+1);
        track.add(midiEvent);
      }

      MidiSystem.write(sequence, 0, outFile);
    }
    catch(Exception e)
    {
      println("Caught Exception");
      e.printStackTrace();
    }
  }
}
