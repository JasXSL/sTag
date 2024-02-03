/*
	Basic test that checks for primary and secondary characteristics of an avatar
*/
#include "../stag.lsl"

output( string label, list data ){
	
	string out = "Undefined";
	if( data )
		out = llList2CSV(data);
	llOwnerSay(label + " >> " + out);

}

default
{
    state_entry()
    {
        key t = llGetOwner();
		
		llOwnerSay("Scanning "+llGetDisplayName(t));
		output("Species", (list)sTag$species(t));
        output("Sex", (list)sTag$sex(t));
		output("Pronouns", (list)sTag$pronouns(t));
		output("Subspecies", (list)sTag$subspecies(t));
		output("Tail size (0-5)", (list)sTag$sizeToInt(sTag$tail(t)));
		output("Hair size (0-5)", (list)sTag$sizeToInt(sTag$hair(t)));
		output("Body coating", sTag$body_coat(t));
		output("Body type", (list)sTag$body_type(t));
		output("Outfit tags", (list)sTag$outfit(t));
		
		llOwnerSay("Genitals [type >> size]:");
		integer bits = sTag$getBitsPacked(t);
		output("Penis size", (list)sTag$penisSize(bits));
		output("Vagina", (list)sTag$vagina(bits));
		output("Breasts size", (list)sTag$breastsSize(bits));
		output("Rear size", (list)sTag$rearSize(bits));
		output("Testicles size", (list)sTag$testiclesSize(bits));
		
		
    }
}

