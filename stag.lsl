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


// Takes a standard none/tiny/average/large/huge value and converts it to an int of 0(none), 1(tiny) ... 5(huge). Some categories can also use 6(entirely) returns -1 if not found
// Note that this only works when the size identifier starts off the string. So bits size uses a different method further down.
#define sTag$sizeToInt( size ) llSubStringIndex("ntsalhe", llGetSubString(size, 0, 0))

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
/*
	Getting bodypart size is done through the bits category.
	Since avatar scanning can be slow if done a lot, I strongly recommend using sTag$getBitsPacked, which will return an integer as a 4-bit array:
	integer bits = sTag$getBitsPacked(uuid);
	Then you can extract the genital sizes by using the sTag$<genital>Size macros, except for vagina which is just sTag$vagina since it doesn't support the size tags:
	integer penisSize = sTag$penisSize(bits); // 0 = none, 1 = tiny, 3 = average, 5 = huge etc.
	
	If your project isn't adult, you may try to infer genitals from the PG sex tag as a fallback. In that case use sTag$getBitsPackedInfer(). 
	However, this uses more memory, so you may want to REQUIRE use of the adult tags in your project.
*/
#define sTag$getBitsPacked(id) _stgb(sTag$bits(id))
#define sTag$getBitsPackedInfer(id) _stib(id)
#define sTag$bits( targ ) sTagAv(targ, "bits", [], 0) // gets all bits tags. I recommend using getBitsPacked, because it manages sizes for you

// Offsets in the packed bits array
#define sTag$bitoffs$penis 0
#define sTag$bitoffs$vagina 4
#define sTag$bitoffs$breasts 8
#define sTag$bitoffs$rear 12
#define sTag$bitoffs$testicles 16

#define sTag$penisSize( bitmask ) (bitmask&0xF)
#define sTag$vagina( bitmask ) ((bitmask&(0xF<<sTag$bitoffs$vagina))>0)
#define sTag$breastsSize( bitmask ) ((bitmask&(0xF<<sTag$bitoffs$breasts))>>sTag$bitoffs$breasts)
#define sTag$rearSize( bitmask ) ((bitmask&(0xF<<sTag$bitoffs$rear))>>sTag$bitoffs$rear)
#define sTag$testiclesSize( bitmask ) ((bitmask&(0xF<<sTag$bitoffs$testicles))>>sTag$bitoffs$testicles)

// Genital functions
integer _stgb( list tags ){

	integer out = (3<<sTag$bitoffs$rear)|(0xF<<sTag$bitoffs$testicles); // default butt and testicles
	integer i = tags != [];
	while( i-- ){
		
		string tag = llList2String(tags, i);
		integer pos = llSubStringIndex("pvbrt", llGetSubString(tag, 0, 0));
		if( ~pos ){
		
			integer us = llSubStringIndex(tag, "_");
			// ntsmalh
			integer size = 3;
			if( ~us )
				size = sTag$sizeToInt(llGetSubString(tag, us+1,us+1));
			
			out = out & ~(0xF<<(pos*4)) | (size<<(pos*4));

		}
		
	}
	
	// If penis is set, but not testicles, set testicles to 3
	int t = sTag$testiclesSize(out);
	if( t == 0xF )
		t = 3*(sTag$penisSize(out)>0);
	out = out & ~(0xF<<sTag$bitoffs$testicles) | (t<<sTag$bitoffs$testicles);

	return out;
}

integer _stib( key id ){
	
	list tags = sTag$bits(id);
	if( tags )
		return _stgb(tags);
	// No adult tags set. Let's try infering it.
	string sex = llList2String(sTag$sex(id), 0);
	integer out = 3<<sTag$bitoffs$rear;
	if( sex == "female" )
		out = out | (3<<sTag$bitoffs$vagina)|(3<<sTag$bitoffs$breasts);
	else if( sex == "male" )
		out = out | (3<<sTag$bitoffs$penis)|(3<<sTag$bitoffs$rear);
	return out;
	
}


// this is 
// returns a 4 bit array of genital sizes for id. You can use the sTag$<bit>Size() methods to turn this value into a number 


#define sTag$bitsBitmask( targ ) _stbbm(sTagAv(targ, "bits", [], 0)) // Converts bits to a JasX standard genitals bitmask

#endif
