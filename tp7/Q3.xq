
declare default element namespace "http://www.expression.org";

declare option saxon:output "omit-xml-declaration=yes";

 (: la fonction prend en parametre les  fichiers  expression  et variable :)

declare function local:eval-var($name as xs:string, $variables as xs:string) as xs:integer{


	local:evalNodeVar(doc($name)//expr/*, $variables) (: premier paramettre le contenu de l xpression et second  parametre le variable xml :)
}; 

declare function local:evalNodeVar($noeud as node(), $variables as xs:string) as xs:integer{


	if (string(node-name($noeud)) = "op") then
	
		let $val1 := local:evalNodeVar($noeud/*[1], $variables)
		
		let $val2 := local:evalNodeVar($noeud/*[2], $variables)
		
		return local:calculer($val1, string($noeud/@val), $val2)
		
	else if (string(node-name($noeud)) = "var") then
	
		local:evalVar($noeud, $variables) (: comme dans la question precedente cette fois ci on evalue les variables d'où on recupere  lenoeud courant  et le fichier variable  xml  :)
		
		


	else
		xs:int($noeud)
};


declare function local:evalVar($noeud as node(), $variables as xs:string) as xs:integer{

	if (count(doc($variables)//*[name() = $noeud/text()]) = 0) then  (: on verifie  si le noeud courant de l'expression.xml correspond pas 

	à un nom de variable de fichier variables.xml :)


	
	
		fn:error(xs:QName("ERROR"), "variable not found")
		
	else if (count(doc($variables)//*[name() = $noeud/text()]) > 1) then (: si une variable apparait plus d'une  fois  on affiche le message

	d'erreur si  après :)
	
		fn:error(xs:QName("ERROR"), "too much occurence for the same variable")
	else
		xs:integer(doc($variables)//*[name() = $noeud/text()]) (: en cas de pas de soucis on fait un caste  et on recupere le contenu de variable :)
};


declare function local:calculer($cons1 as xs:integer, $op as xs:string, $cons2 as xs:integer) as xs:integer {

	if ($op = "+") then
	
		$cons1 + $cons2
		
	else if ($op = "/") then
	
		xs:integer($cons1 div $cons2)
		
	else if ($op = "*") then 
	
		$cons1 * $cons2
	else 
		$cons1 - $cons2
};


local:eval-var("expression.xml","variables.xml")





