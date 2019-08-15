ASCnotes : ASCnotes.c interface.luac fonctions.luac
	gcc ASCnotes.c -Wall -llua -lm -ldl -o ASCnotes

interface.luac : interface.lua
	luac -o interface.luac interface.lua

fonctions.luac : fonctions.lua
	luac -o fonctions.luac fonctions.lua

install :
	mkdir -p /usr/local/share/ASCnotes
	mv interface.luac /usr/local/share/ASCnotes
	mv fonctions.luac /usr/local/share/ASCnotes
	mv ASCnotes /usr/local/bin

clean : 
	rm -f ASCnotes
	rm -f *.luac

uninstall : 
	rm -f /usr/local/bin/ASCnotes
	rm -Rf /usr/local/share/ASCnotes

