#!/bin/bash

export CLASSPATH="lib/antlr-4.7.2-complete.jar:$CLASSPATH"
alias antlr4='java -jar lib/antlr-4.7.2-complete.jar'
alias grun='java org.antlr.v4.gui.TestRig'
antlr4 Hello.g4
javac Hello*.java
