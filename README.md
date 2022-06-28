# Markov Chains
 Musical Fun with Markov Chains!

Inspired by [Iannis Xenakis](https://en.wikipedia.org/wiki/Iannis_Xenakis), this is an example of a **Markov Chain** in [Processing](https://processing.org) to compose MIDI Files.


## MarkovChain01_Basic.pde
This is an implementation of a Markov Chain based on this example here:
[https://towardsdatascience.com/introduction-to-markov-chain-programming-8ddbe0ac1c84](https://towardsdatascience.com/introduction-to-markov-chain-programming-8ddbe0ac1c84)

## MarkovChain02_Midi.pde
This trains a Markov Chain with a MIDI File and creates new compositions from it.

Currently, only the notes are considered. No timing, note-length, velocity or anything else is implemented.

Beethoven Sonatas as Midi Files can be found here 🙂
[https://www.kunstderfuge.com/beethoven/sonatas.htm]()


## MidiReadWrite Example.pde
This is a very basic example on how to use the `javax.sound.midi` classes to **read and write MIDI files**.

Helpful code snippets for **Java MIDI usage** can also be found here:

* [https://www.tabnine.com/code/java/classes/javax.sound.midi.MidiSystem](https://www.tabnine.com/code/java/classes/javax.sound.midi.MidiSystem)
* [https://discourse.processing.org/t/parse-midi-files/14126](https://discourse.processing.org/t/parse-midi-files/14126)
