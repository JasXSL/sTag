/*
	This is a library of helpful functions to work with sTag
	It's designed to work with firestorm preprocessor #include 
	But you can just as well copy invidivual functions to your project
	You don't have to use these functions, and are very welcome to roll your own. However, if you do improve on these, consider making a pull request!
*/
#ifndef __stag
#define __stag
	

/*
	Parses an avatar by ID and returns a list of tags
	If defaultVal is set, and the avatar doesn't have the tag, or isn't wearing any sTag objects, defaultVal is returned
	id : UUID of avatar
	category : (Optional)If category is not empty, only gets tags starting with the specified category, and the category is omitted from the results to save some memory.
*/
list sTagAv( key id, string category, list defaultVal ){
    
    list l = llGetAttachedList(id);
    list out; integer i = (l != []);
	list add;
    while( i-- ){
        
		out += sTag(
            llList2String(llGetObjectDetails(llList2Key(l, i), (list)OBJECT_DESC), 0),
            category
        );

	}
	if( out == [] )
		return defaultVal;
    return out;
    
}
/*
	Returns all tags from a description string. If category is empty, it only returns those tags, and removes the category from the tags to save memory.
*/
list sTag( string desc, string category ){
    
    list spl = llParseString2List(desc, (list)"$$", []);
    integer i = spl != [];
    list out;
    while( i-- ){
        
        if( llGetSubString(llList2String(spl, i), 0, 3) == "TAG$" ){
            
            list sub = llParseString2List(
                llGetSubString(llList2String(spl, i), 4, -1),
                (list)"$", []
            );
            
            string pre;
            integer n;
            for(; n < (sub != []); ++n ){
                
                string val = llToLower(llList2String(sub, n));
                if( llOrd(val, 0) == 0x21 ){ // Check for !
                    
                    pre = llDeleteSubString(val, 0, 0);
                    val = "";
                    
                }
                else if( pre )
                    val = pre+"_"+val;        
                
                if( 
                    llStringLength(val) && (
                        !llStringLength(category) ||
                        llGetSubString(val, 0, llStringLength(category)) == category+"_"
                    )
                ){
				
					// If category is set, we remove category from the output
					if( category )
						val = llDeleteSubString(val, 0, llStringLength(category));
					out += val;
					
                }
				
            }
            
        }
        
    }
	
    return out;
    
}


/*
	Returns TRUE if id has at least one object with sTag on it
	This is mainly for testing. You're better off using sTagAv without checking for the existence of sTag
*/
integer sTagExists( key id ){

	list l = llGetAttachedList(id);
	list out; integer i = (l != []);
	while( i-- ){
		
		list spl = llParseString2List(
			llList2String(
				llGetObjectDetails(
					llList2Key(l, i),
					(list)OBJECT_DESC
				),
				0
			),
			(list)"$$",
			[]
		);
		integer n = spl != [];
		while( n-- ){
			
			if( llGetSubString(llList2String(spl, n), 0, 3) == "TAG$" )
				return TRUE;
			
		}
		
	}
	return FALSE;
	
}


// Takes a standard none/tiny/average/large/huge value and converts it to an int of 0(none), 1(tiny) ... 5(huge), returns -1 if size is invalid
#define sizeToInt( size ) llListFindList((list)"none" + "tiny" + "small" + "average" + "large" + "huge", (list)(size))

/* Macros with any default values already set. These are only provided for Primary and Secondary categories. */

#define sTag$species( targ ) sTagAv(targ, "species", [])
#define sTag$sex( targ ) sTagAv(targ, "sex", [])
#define sTag$pronouns( targ ) sTagAv(targ, "pronouns", [])
#define sTag$subspecies( targ ) sTagAv(targ, "subspecies", [])
#define sTag$tail_type( targ ) sTagAv(targ, "tail_type", [])
#define sTag$hair_type( targ ) sTagAv(targ, "hair_type", [])
#define sTag$body_coat( targ ) sTagAv(targ, "body_coat", ["skin"])
#define sTag$body_color( targ ) sTagAv(targ, "body_color", [])
#define sTag$body_type( targ ) sTagAv(targ, "body_type", ["biped"])
#define sTag$outfit( targ ) sTagAv(targ, "outfit", [])



/* Adult */
// This converts bits to a JasX bitmask where 1 = penis, 2 = vagina, 4 = breasts
integer _stbbm( list bitsTags ){
	
	list template = (list)"penis" + "vagina" + "breasts";
	integer out; integer i = bitsTags != [];
	while( i-- ){
		// bits may include an additional size tag, so we'll have to remove that
		string sub = llGetSubString(llList2String(template, i), 0, llSubStringIndex(llList2String(template, i), "_"));
		integer pos = llListFindList(template, (list)sub);
		if( ~pos )
			out = out | (1<<pos);
		
	}
	return out;
	
}

#define sTag$bits( targ ) sTagAv(targ, "bits", [])
#define sTag$bitsBitmask( targ ) _stbbm(sTagAv(targ, "bits", [])) // Converts bits to a JasX standard genitals bitmask
#define sTag$butt_size( targ ) sTagAv(targ, "butt_size", [])

#endif
