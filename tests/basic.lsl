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
		output("Species", sTag$species(t));
        output("Sex", sTag$sex(t));
		output("Pronouns", sTag$pronouns(t));
		output("Subspecies", sTag$subspecies(t));
		output("Tail size (0-5)", (list)sTag$sizeToInt((string)sTag$tail(t)));
		output("Hair size (0-5)", (list)sTag$sizeToInt((string)sTag$hair(t)));
		output("Body coating", sTag$body_coat(t));
		output("Body type", sTag$body_type(t));
		output("Outfit tags", sTag$outfit(t));
		output("Butt size (0-5)", (list)sTag$sizeToInt((string)sTag$butt(t)));
		
		llOwnerSay("Genitals [type >> size]:");
		list bits = sTag$bits( t );
        integer i;
        for(; i < (bits != []); ++i ){
            string bit = llList2String(bits, i);
            llOwnerSay(
				"-- " +
                sTag$genitalName(bit)+
                " >> "+
                (string)sTag$bitsSize(bit)
            );
        }
		
    }
}

