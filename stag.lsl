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
	max : (int)max results to fetch, <1 means infinite
*/
list sTagAv( key id, string category, list defaultVal, integer max ){
    
    list l = llGetAttachedList(id);
    list out; integer i = (l != []);
	list add;
    while( i-- ){
        
		out += sTag(
            llList2String(llGetObjectDetails(llList2Key(l, i), (list)OBJECT_DESC), 0),
            category
        );
		
		if( max > 0 && (out != []) >= max )
			return llList2List(out, 0, max-1);
			
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


// Takes a standard none/tiny/average/large/huge value and converts it to an int of 0(none), 1(tiny) ... 5(huge). returns -1 if not found
// Note that this only works when the size identifier starts off the string. So bits size uses a different method further down.
#define sTag$sizeToInt( size ) llSubStringIndex("ntsalh", llGetSubString(size, 0, 0))

/* Macros with any default values already set. These are only provided for Primary and Secondary categories. */

#define sTag$species( targ ) sTagAv(targ, "spec", [], 1)
#define sTag$spec( targ ) sTagAv(targ, "spec", [], 1)

#define sTag$sex( targ ) sTagAv(targ, "sex", [], 1)

#define sTag$pronouns( targ ) sTagAv(targ, "pnoun", [], 1)
#define sTag$pnoun( targ ) sTagAv(targ, "pnoun", [], 1)

#define sTag$subspecies( targ ) sTagAv(targ, "subs", [], 1)
#define sTag$subspec( targ ) sTagAv(targ, "subs", [], 1)

#define sTag$tail( targ ) sTagAv(targ, "tail", [], 1)

#define sTag$hair( targ ) sTagAv(targ, "hair", [], 1)

#define sTag$body_coat( targ ) sTagAv(targ, "bdycoat", ["skin"], 0)
#define sTag$bdycoat( targ ) sTagAv(targ, "bdycoat", ["skin"], 0)

#define sTag$body_type( targ ) sTagAv(targ, "bdytpe", ["biped"], 1)
#define sTag$bdytpe( targ ) sTagAv(targ, "bdytpe", ["biped"], 1)

#define sTag$body_fat( targ ) sTagAv(targ, "bdyfat", ["bdyfat_average"], 1)
#define sTag$bdyfat( targ ) sTagAv(targ, "bdyfat", ["bdyfat_average"], 1)

#define sTag$body_muscle( targ ) sTagAv(targ, "bdymscl", ["bdymscl_average"], 1)
#define sTag$bdymscl( targ ) sTagAv(targ, "bdymscl", ["bdymscl_average"], 1)



#define sTag$outfit( targ ) sTagAv(targ, "ofit", [], 0)
#define sTag$ofit( targ ) sTagAv(targ, "ofit", [], 0)






/* Adult */
// This converts bits to a JasX bitmask where 1 = penis, 2 = vagina, 4 = breasts
integer _stbbm( list bitsTags ){
	
	string template = "pvb"; // Penis vagina breasts
	integer out; integer i = bitsTags != [];
	while( i-- ){
		// bits may include an additional size tag, so we'll have to remove that
		integer pos = llSubStringIndex(template, llGetSubString(llList2String(bitsTags, i), 0, 0));
		if( ~pos )
			out = out | (1<<pos);
		
	}
	return out;
	
}

// Genital functions
#define sTag$bits( targ ) sTagAv(targ, "bits", [], 0)
#define sTag$bitsBitmask( targ ) _stbbm(sTagAv(targ, "bits", [], 0)) // Converts bits to a JasX standard genitals bitmask
#define sTag$bitsSize(tag) /* Fetches a size value from a bits tag. Returns -1 if not found */ \
	sTag$sizeToInt(llList2String(llParseString2List(tag, (list)"_", []), -1)) 
#define sTag$genitalName(tag) /* Turns a genital tag into "penis", "vagina", or "breasts" */ \
	llList2String((list) \
		"penis" + "vagina" + "breasts", \
		llListFindList( \
			(list)112/*p*/ + 118/*v*/ + 98/*b*/,  \
			(list)llOrd(tag, 0) \
		) \
	)

#define sTag$butt( targ ) sTagAv(targ, "butt", [], 1)

#endif
