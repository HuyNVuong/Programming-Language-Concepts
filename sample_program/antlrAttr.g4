grammar antlrAttr;
decl
	: type ID ';'
	 {System.out.println("var "+$ID.text+":"+$type.text+";");}
	| t=ID id=ID ';'
     	 {System.out.println("var "+$id.text+":"+$t.text+";");}
	;
type: 'int' | 'float';
