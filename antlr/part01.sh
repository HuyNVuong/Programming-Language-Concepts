alias antlr4='java -jar lib/antlr-4.7.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
# Build path for jar file
export CLASSPATH="lib/antlr-4.7.2-complete.jar:$CLASSPATH"
# Compile the antlr file
antlr4 csce322assignment01part01.g4
# Compile lexer and parse file (java)
javac csce322assignment01part01*.java
# Run the program with given test cases parsed via CLAs
grun csce322assignment01part01 connectFour -gui "$@" 
