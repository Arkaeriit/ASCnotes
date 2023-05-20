## ASCnotes
A terminal-based program made in lua I use to take notes.

![Alt text](https://i.imgur.com/TYkmlfw.png "An example of notes")

To install this program just do
```bash
make && sudo make install
```
The basic way to use this program are the following:
* Use `ASCnotes add`:     take a note
* Use `ASCnotes read`:    read your notes
* Use `ASCnotes del <n>`: delete the n-th note you took


To use the program automaticaly, as I intended, there is more option:
* Use `ASCnotes read <time to wait in seconds>`: read your notes. If you do this command again, nothing will be shown untin the time to wait has expired.

To use this progral I put 
```bash
ASCnotes read 21600
```
in my .bashrc file. Thus, my notes are read once every 6 hours.

