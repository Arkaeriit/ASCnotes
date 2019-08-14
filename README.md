## ASCnotes
A terminal-based program made in lua I use to take notes.

![Alt text](https://i.imgur.com/TYkmlfw.png "An example of notes")

To install this program just do
```bash
make && sudo make install
```
The basic way to use this program are the following:
* Use `ASCnotes add`       to take a note
* Use `ASCnotes readF`    to read your notes
* Use `ASCnotes del n`    to delete the n-th note you took


To use the program automaticaly, as I intended, there is more option:
* Use `ASCnotes read `    to read your notes once
* Use `ASCnotes reset`    to be able to read your notes using the read option again

To use this progral I put 
```bash
ASCnotes read 
```
in my .bashrc file and I crate a cron jobs which use the command
```bash
ASCnotes reset
```
every time I restart my computer and every 6 hours
