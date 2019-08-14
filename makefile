
fonctions.luac : fonctions.lua
	luac -o fonctions.luac fonctions.lua

install : interface.lua fonctions.luac
	mkdir -p /usr/local/share/ASCnotes
	cp interface.lua ASCnotes
	chmod 755 ASCnotes
	mv ASCnotes /usr/local/bin
	mv fonctions.luac /usr/local/share/ASCnotes

clean : 
	rm -f ASCnotes
	rm -f *.luac

uninstall : clean
	rm -f /usr/local/bin/ASCnotes
	rm -Rf /usr/local/share/ASCnotes
