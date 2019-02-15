grammar Hello;
r  : 'hello' ID; 
ID : [a-z]+;
WD : [ \t\r\n]+ -> skip;
