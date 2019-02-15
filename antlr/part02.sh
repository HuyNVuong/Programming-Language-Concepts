alias antlr4='java -jar lib/antlr-4.7.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
# Export jar file
export CLASSPATH="lib/antlr-4.7.2-complete.jar:$CLASSPATH"
# Compile antlr file
antlr4 csce322assignment01part02.g4
# Compile Parser and Lexer files(java)
javac csce322assignment01part02*.java
# Execute the compiled file with input via CLAs
grun csce322assignment01part02 connectFour -gui "$@" 
