
import org.xml.sax.*;
import org.xml.sax.helpers.* ;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;


public class LABDHandler extends DefaultHandler {


    private double somme_surface =0;

    private boolean inclu = false;


    public void startDocument() throws SAXException {
        System.out.println("Debut du document");
    }


    public void endDocument() throws SAXException {
        System.out.println("Fin du document" );
    }



    public void startElement(String nameSpaceURI, String localName, String rawName, Attributes attributs) throws SAXException {
        //System.out.println("Ouverture de la balise : " + localName) ;


        if (attributs.getLength() != 0)// System.out.println("  Attributs de la balise : ") ;
            for (int index = 0; index < attributs.getLength(); index++) { // on parcourt la liste des attributs

                if(attributs.getLocalName(index).equals("id")){

                    System.out.println("Maison " + attributs.getValue(index) + ":");
                }
                if(!inclu){
                    if(attributs.getLocalName(index).equals("surface-m2")){
                        //System.out.println( attributs.getLocalName(index) + " = " + Double.parseDouble(attributs.getValue(index)));
                        somme_surface+=Double.parseDouble(attributs.getValue(index));
                        inclu = true;

                    }
                }
            }

    }


    public void endElement(String nameSpaceURI, String localName, String rawName) throws SAXException {
        //System.out.println("Fermeture de la balise : " + localName);
        if(localName.equals("maison")){

            System.out.println("superficie totale "+ somme_surface + "m²");

            somme_surface =0;
        }
        inclu = false;
    }


    public void characters(char[] ch, int start, int length) throws SAXException {
        String s = new String(ch, start, length).trim() ;
        if (s.length() > 0) ;//System.out.println("     Contenu : |" + s + "|");
    }


    public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
        System.out.println("espaces inutiles rencontres : ..." + new String(ch, start, length) +  "...");
    }


    public void processingInstruction(String target, String data) throws SAXException {
        System.out.println("Instruction de traitement : " + target);
        System.out.println("  dont les arguments sont : " + data);
    }




    public static void main(String[] args) {
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();
            XMLReader reader = parser.getXMLReader();
            reader.parse(new InputSource("maisons.xml"));

        } catch (Exception t) {
            t.printStackTrace();
        }
    }


}
