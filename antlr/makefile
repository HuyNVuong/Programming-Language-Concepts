export CLASSPATH="lib/antlr-4.7.2-complete.jar:$CLASSPATH"

part01:
	java -jar lib/antlr-4.7.2-complete.jar csce322assignment01part01.g4
	javac csce322assignment01part01*.java

part02:
	java -jar lib/antlr-4.7.2-complete.jar csce322assignment01part02.g4
	javac csce322assignment01part02*.java

clean:
	rm -f csce322assignment01part01*.java *.class 
	rm -f *.interp *.tokens 
	rm -f *.ps
	rm -f csce322assignment01part02Parse*.java csce322assignment01part02.interp
	rm -f csce322assignment01part02Lexer*.java csce322assignment01part02.tokens
	rm -f csce322assignment01part02Listener.java csce322assignment01part02BaseListener.java
