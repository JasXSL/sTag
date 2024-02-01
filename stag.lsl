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
                
                string val = llList2String(sub, n);
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



#endif
