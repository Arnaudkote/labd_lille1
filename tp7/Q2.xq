
declare default element namespace "http://www.expression.org";

declare option saxon:output "omit-xml-declaration=yes";



declare function local:eval($name as xs:string) as xs:integer {

	local:evalNode(doc($name)//expr/*)
};


declare function local:evalNode($noeud as node()) as xs:integer {
	if (string(node-name($noeud)) = "op") then
		let $val1 := local:evalNode($noeud/*[1])
		let $val2 := local:evalNode($noeud/*[2])
		return local:calculer($val1, string($noeud/@val), $val2)
	else if (string(node-name($noeud)) = "var") then 
		fn:error(xs:QName("ERROR"), "les variables sont interdites!")
	else
		xs:int($noeud)
};


declare function local:calculer($cons1 as xs:integer, $op as xs:string, $cons2 as xs:integer) as xs:integer {


(:pour chaque cas l'operateur on fait l'operation :)

	if ($op = "+") then
		$cons1 + $cons2
	else if ($op = "/") then
		xs:integer($cons1 div $cons2)  (: xs:intege, on recupere  la partie zentiere car la fonction renvoie un integer :)
	else if ($op = "*") then 
		$cons1 * $cons2
	else 
		$cons1 - $cons2
};


local:eval("constante.xml")


(: un autre fichier xml  a été créer constante.xml  qui  correspond à l' E1 de l'enoncé :)





