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
	while( i-- ){
	
		out += sTag(
            (string)llGetObjectDetails(llList2Key(l, i), (list)OBJECT_DESC),
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

	if( desc == "" || desc == "(No Description)")
		return [];
	
    list spl = llParseString2List(desc, (list)"$$", []);
    integer i = spl != [];
    list out;
    while( i-- ){
        
		list sub = llParseString2List(
			llList2String(spl, i),
			(list)"$", []
		);
        if( llList2String(sub, 0) == "TAG" ){
            
            string pre;
            integer n;
            for( n = 1; n < (sub != []); ++n ){
                
                string val = llToLower(llList2String(sub, n));
                if( llOrd(val, 0) == 0x21 ){ // Check for ! which sets category for future things
                    
                    pre = llDeleteSubString(val, 0, 0);
                    val = "";
                    jump stagC;
					
                }
				
				// Parse the tag
				list tc = llParseString2List(val, (list)"_", []);
				string s = pre;
				if( pre == "" ){
					s = llList2String(tc, 0);
					tc = llDeleteSubList(tc, 0, 0);
				}
				if( category == "" || s == category ){
				
					if( category == "" )
						tc = (list)s + tc;
					// If category is set, we remove category from the output
					out = out + llDumpList2String(tc, "_");
					
                }
				
				@stagC;
				
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

/* 
	Macros with any default values and single/multi already set. These are only provided for Primary and Secondary categories. 
	If a category may only have a SINGLE item, that tag will be returned as a string or "" if not set
*/

#define sTag$species( targ ) llList2String(sTagAv(targ, "spec", [], 1), 0)
#define sTag$spec( targ ) sTag$species(targ)

#define sTag$sex( targ ) llList2String(sTagAv(targ, "sex", [], 1), 0)

#define sTag$pronouns( targ ) llList2String(sTagAv(targ, "pnoun", [], 1), 0)
#define sTag$pnoun( targ ) sTag$pronouns(targ)

#define sTag$subspecies( targ ) llList2String(sTagAv(targ, "subs", [], 1), 0)
#define sTag$subs( targ ) sTag$subspecies(targ)

#define sTag$tail( targ ) llList2String(sTagAv(targ, "tail", [], 1), 0)

#define sTag$hair( targ ) llList2String(sTagAv(targ, "hair", [], 1), 0)

#define sTag$body_coat( targ ) sTagAv(targ, "bdycoat", ["skin"], 0)
#define sTag$bdycoat( targ ) sTag$body_coat(targ)

#define sTag$body_type( targ ) llList2String(sTagAv(targ, "bdytpe", ["biped"], 1), 0)
#define sTag$bdytpe( targ ) sTag$body_type(targ)

#define sTag$body_fat( targ ) llList2String(sTagAv(targ, "bdyfat", ["average"], 1), 0)
#define sTag$bdyfat( targ ) sTag$body_fat(targ)

#define sTag$body_muscle( targ ) llList2String(sTagAv(targ, "bdymscl", ["average"], 1), 0)
#define sTag$bdymscl( targ ) sTag$body_muscle(targ)



#define sTag$outfit( targ ) sTagAv(targ, "ofit", [], 0)
#define sTag$ofit( targ ) sTag$outfit(targ)


// Outfit functions
/*
	Tries to create a JSON object with a key for each outfit item. Note that if you've tagged the same item multiple times, (such as multiple bracelets), the tags will all be merged.
	Ex: ofit_wrist_watch and ofit_wrist_bracelet would become "wrist":["watch","bracelet"]
	
	Example:
	
*/
#define sTag$outfit2json( targ ) _stotj( sTag$outfit( targ ) )
string _stotj( list tags ){
	string out = "{}";
	integer i = tags != [];
	while( i-- ){
		
		list s = llParseString2List(llList2String(tags, i), (list)"_", []);
		string t = llList2String(s, 0); // Tag
		s = llDeleteSubList(s, 0,0);
		list cur;
		string c = llJsonGetValue(out, (list)t);
		if( c != JSON_INVALID )
			cur = llJson2List(c);
		cur = cur + s;
		out = llJsonSetValue(out, (list)t, llList2Json(JSON_ARRAY, cur));
		
	}
	
	return out;
}








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
#define sTag$vagina( bitmask ) (((bitmask>>sTag$bitoffs$vagina)&0xF)>0)
#define sTag$breastsSize( bitmask ) ((bitmask>>sTag$bitoffs$breasts)&0xF)
#define sTag$rearSize( bitmask ) ((bitmask>>sTag$bitoffs$rear)&0xF)
#define sTag$buttSize( bitmask ) sTag$rearSize( bitmask )
#define sTag$testiclesSize( bitmask ) ((bitmask>>sTag$bitoffs$testicles)&0xF)


#define sTag$genitalName( tag ) llList2String((list)"penis" + "vagina" + "breasts" + "rear" + "testicles", llSubStringIndex("pvbrt", llGetSubString(tag, 0, 0)))

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
	integer t = sTag$testiclesSize(out);
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





/*
	== CACHING FUNCTIONS ==
	Scanning each value is quite time intensive, expect somewhere around 70ms per read.
	If you need to check many players against many values in a loop, you may want to add a cache to speed things up.
	
	- This does consume a fair amount of memory and linkset data space. 
	- Each time you read a value it gets cached for STAG_CACHE_DUR seconds.
	- This is mainly used in cases where you need to run lots of comparisons at once.
	- Whenever you read a category with sTag$cache$get, it stores the value in linkset data using STAG_CACHE_PREFIX+uuid+category, and the time in STAG_CACHE_PREFIX+uuid+category
	- You can also use sTag$cache$getBitsPacked(uuid) to cache the packed bit size numbers
	- You can also use sTag$cache$outfit2json(uuid) to cache the whole outfit JSON string.
	
	If you know all the categories you need ahead of time, the fastest way is to call sTag$cache$multi( key uuid, list categories ) which will force cache all those categories at once
	If you're only interested in a few categories at a time, you can use sTag$cache$get( key uuid, string category, list defaultVal, integer max ) to fetch a single value. If the value isn't cached, or the cache has expired, it'll be fetched anew.
	
	sTag$cache$reset() dumps the cache
	sTag$cache$remove(uuid) removes all cached values for a UUID
	
	== Cache Benchmark: ==
		llResetTime();
        sTag$cache$multi(llGetOwner(), (list)
            "bits" + 
            "sex" +
            "spec" +
            "subs"
        );
        integer i;
        for(; i < 100; ++i ){
            integer packed = sTag$cache$getBitsPacked(llGetOwner());
            sTag$breastsSize(packed);
            sTag$cache$outfit2json(llGetOwner());
            sTag$cache$get(llGetOwner(), "sex", [], 1);
            sTag$cache$get(llGetOwner(), "subs", [], 1);
        }
        llOwnerSay((string)llGetTime());
	Result: 0.55 seconds
	
	== Uncached Benchmark ==
		llResetTime();
        integer i;
        for(; i < 100; ++i ){
            integer packed = sTag$getBitsPacked(llGetOwner());
            sTag$breastsSize(packed);
            sTag$outfit2json(llGetOwner());
            sTag$sex(llGetOwner());
            sTag$subs(llGetOwner());
        }
        llOwnerSay((string)llGetTime());
	Result: 28 seconds
	
*/
/* LSD caching system */
#ifndef STAG_CACHE_PREFIX
	#define STAG_CACHE_PREFIX "sTag" // LSD key, uses the syntax: STAG_CACHE_PREFIX+uuid+category -> (arr/str)value(s), STAG_CACHE_PREFIX+"t"+uuid+category -> (int)unix_time
#endif
#ifndef STAG_CACHE_DUR
	#define STAG_CACHE_DUR 10
#endif

#define sTag$cache$reset() llLinksetDataDeleteFound("^"+STAG_CACHE_PREFIX, "")
#define sTag$cache$remove(uuid) llLinksetDataDeleteFound("^"+STAG_CACHE_PREFIX+"(t?)"+(string)uuid, "")
#define sTag$cache$get(uuid, category, defaultVal, max) _stcg(uuid, category, defaultVal, max) 
list _stcg( key uuid, string category, list defaultVal, integer max ){

	integer u = llGetUnixTime();
	integer time = (integer)llLinksetDataRead(STAG_CACHE_PREFIX+"t"+(string)uuid+category);
	if( u-time > STAG_CACHE_DUR || !time ){
		
		// Need recache
		list tags = sTagAv(uuid, category, defaultVal, max);
		llLinksetDataWrite(STAG_CACHE_PREFIX+(string)uuid+category, llList2Json(JSON_ARRAY, tags));
		llLinksetDataWrite(STAG_CACHE_PREFIX+"t"+(string)uuid+category, (string)llGetUnixTime());
		
	}
	
	return llJson2List(llLinksetDataRead(STAG_CACHE_PREFIX+(string)uuid+category));	

}

// Note that this doesn't support defaults
#define sTag$cache$multi(uuid, categories) _stcm(uuid, categories)
_stcm( key uuid, list categories ){
	
	list all = sTagAv( uuid, "", [], 0);
	all = llListSort(all, 1, TRUE);
	integer i; string desc; list pack;
	for(; i <= (all != []); ++i ){
		
		list spl = llParseString2List(llList2String(all, i), (list)"_", []);
		string cat = llList2String(spl, 0);
		if( cat != desc || (i == (all != []) && pack != []) ){
			
			if( cat ){
				llLinksetDataWrite(STAG_CACHE_PREFIX+(string)uuid+desc, llList2Json(JSON_ARRAY, pack));
				llLinksetDataWrite(STAG_CACHE_PREFIX+"t"+(string)uuid, (string)llGetUnixTime());
			}
			pack = [];
			desc = cat;
			
		}
		pack += llDumpList2String(llDeleteSubList(spl, 0, 0), "_");
		
	}
	
}


// Gets bits packed
integer _stcgbp( key uuid ){

	integer u = llGetUnixTime();
	integer time = (integer)llLinksetDataRead(STAG_CACHE_PREFIX+"t"+(string)uuid+"€"); // Category is set to "€" since that can't be tagged
	if( u-time > STAG_CACHE_DUR || !time ){
		integer n = _stgb(sTag$cache$get(uuid, "bits", [], 0));
		llLinksetDataWrite(STAG_CACHE_PREFIX+(string)uuid+"€", (string)n);
		llLinksetDataWrite(STAG_CACHE_PREFIX+"t"+(string)uuid+"€", (string)llGetUnixTime());
	}
	return (integer)llLinksetDataRead(STAG_CACHE_PREFIX+(string)uuid+"€");

}

string _stco2j( key uuid ){

	integer u = llGetUnixTime();
	integer time = (integer)llLinksetDataRead(STAG_CACHE_PREFIX+"t"+(string)uuid+"$"); // Category is set to "$" since that can't be tagged
	if( u-time > STAG_CACHE_DUR || !time ){
		string d = _stotj(sTag$cache$get(uuid, "ofit", [], 0));
		llLinksetDataWrite(STAG_CACHE_PREFIX+(string)uuid+"$", d);
		llLinksetDataWrite(STAG_CACHE_PREFIX+"t"+(string)uuid+"$", (string)llGetUnixTime());
	}
	return llLinksetDataRead(STAG_CACHE_PREFIX+(string)uuid+"$");

}

#define sTag$cache$getBitsPacked(id) _stcgbp(id)
#define sTag$cache$outfit2json(id) _stco2j(id)

#endif
