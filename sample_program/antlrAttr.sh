alias antlr4='java -jar lib/antlr-4.7.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH="lib/antlr-4.7.2-complete.jar:$CLASSPATH"
antlr4 antlrAttr.g4
javac antlrAttr*.java
grun antlrAttr decl -gui 
