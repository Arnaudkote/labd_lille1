
declare default element namespace "http://www.expression.org";

declare option saxon:output "omit-xml-declaration=yes";



(:Question 1 :)


declare function local:print($name as xs:string) as xs:string {

	local:printNode(doc($name)//expr/*)  (: on recupere tous les noeuds fils de expr :)
};


declare function local:printNode($noeud as node()) as xs:string {


	if (string(node-name($noeud)) = "op") then  (: on regarde si il s'agit de noeud 	avec le nom op :)
	
		let $val1 := local:printNode($noeud/*[1]) (: on recupere la premiere operande  c'est  à dire le  noeud var et on appel recursivement 

		printNode   qui retourne le contenu de var c'est à dire le x avec fn:data($noeud)  etape 1 :)
		
		let $val2 := local:printNode($noeud/*[2])  (: on recupere la deuxieme operande qui est un operateur -

		de  ce fait à l'appel de printNode on entre dans le if  on recupere le / qui a  6 et - 2  comme operandes :)


		
		return fn:concat("( ", $val1, " ", $noeud/@val, " ", $val2, " )")  (: etape  2 , on affiche (x  + ; + est  l'attribut de l'operateur 
		
		
		etape 4 : on affiche (x  + ((6 / -2) -  y))
		
		
		:)
	else
		fn:data($noeud)
};

local:print("expression.xml")











