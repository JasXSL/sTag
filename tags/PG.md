Legend:
- Category: The tag category. Tags follow the syntax `<category>_<value>`
- Value: The tag value.
  - USER_DEFINED: The value can be anything defined by the user. If used on a category with quant type MULTIPLE, enter them in order of most to least significant. For an instance, fox fur may be dominant orange, then white, then black. You'd do something like `TAG$!body_color$orange$white$black`, letting devs know that orange is the most significant color.
  - X/Y/Z : The value can be one of these. Note that many of these may be subject to interpretation. Just make an estimate and it'll work out!
    - On the values listed as `none/tiny/small/average/large/huge` you can shorten them to n/t/s/a/l/h
  - X,Y,Z : The value should be an ordered CSV following this pattern.
  - X,Y,Z... : The value should be an ordered CSV but has a variable amount of entries specified by the user.
- Default value: The default value that scripters should expect if the tag is not set on an avatar. **If your avatar matches the default value, you should not add the tag to your avatar.**
  - DEVELOPER_DEFINED : The handling of a missing tag is up to the individual developer.
  - N/A : Not applicable, or doesn't exist. If a field is N/A, the scripter should not make assumptions about the field.
  - NONE : If omitted, assume the part doesn't exist. Primarily used for existence checks.
- Quant: Nr of tags of this category that may exist.
  - SINGLE : Only one tag of this category may exist.
  - MULTIPLE : Multiple tags of this category may be used.
- Example: An example use of this tag.
- Recommended Point: A recommended attachment to set the tag on.
- Explanation: Explains the tag (if necessary).

### Primary Tags
These are tags that most users SHOULD use. If you set up any tags at all, set these up.

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Comment</th></tr>
  
  <tr> <td>spec</td> <td>USER_DEFINED</td> <td>N/A</td> <td>SINGLE</td> <td>spec_human</td> <td>Body</td> <td>Sets your avatar's species.</td> </tr> 
  <tr> <td>subs</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>subs_equine</td> <td>Body</td> <td>Subspecies. Gives NPCs leeway when determining your species. Like if an NPC wants to have a cat specific reaction, it could check for subspec_equine instead of keeping a list of every type of cat for the species tag.</td> </tr>
  <tr> <td>sex</td> <td>male/female/USER_DEFINED</td> <td>N/A</td> <td>SINGLE</td> <td>sex_male</td> <td>Body</td> <td>Sets your avatars physical sex. Note: The adult tagset has a "bits" tag which is more granular than this, and should be prioritized over this tag for adult projects. </td></tr>
  <tr><td colspan="7">Clothing. Tagging your clothing is relatively important as otherwise NPCs and scripts may think you're naked! You should be fine with just one tag per piece of clothing!</td></tr>
  <tr> <td>ofit</td> <td>USER_DEFINED</td> <td>NONE</td> <td>MULTIPLE</td> <td>ofit_pants</td> <td>Outfit</td> <td>The Primary outfit tag should contain generalized information about your outfit, but you don't need to go overboard. The values below are standardized. Note: These tags may have subtags, see below.</td> </tr>
  <tr> <td>Standard Primary outfit values (prefix with ofit_):</td> <td colspan="6">
    <ul>
      <li>underpants (includes bikini bottoms/thongs/swimtrunks etc)</li> 
      <li>pants (includes shorts etc)</li> 
      <li>skirt</li>
      <li>dress</li>
      <li>bodysuit (If it's not a dress and covers upper and lower body, it counts. Including one-piece swimsuits and overalls)</li>
      <li>bra (includes bikini tops)</li>
      <li>shirt</li>
      <li>jacket (includes coats etc)</li>
      <li>armor</li>
      <li>leggings (if it's long socks pick this if it's longer than your knees)</li>
      <li>gloves</li>
      <li>glasses (goggles etc)</li>
      <li>hat (helmets, etc)</li>
      <li>wrist (bracelets, watches etc)</li>
      <li>socks</li>
    </ul>  
    <b>Note: I'll need help expanding this</b>
  </td> </tr>
</table>



### Secondary Tags
These are tags that many developers will incorporate to add some depth to their systems, but aren't as important as primary tags. For guidance, what are the immediate characteristics that jump to your mind the moment you see an avatar?

<!-- 
  <tr> <td>category</td> <td>value</td> <td>default</td> <td>quant</td> <td>ex</td> <td>point</td> <td>expl</td> </tr> 
-->

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>
  <tr> <td>pnoun</td> <td>he,him,his / she,her,her / USER_DEFINED</td> <td>DEVELOPER_DEFINED</td> <td>SINGLE</td> <td>pnoun_he,him,his</td> <td>Body</td> <td>Most users can omit this tag. The default value is left up to individual devs, because I'm not touching this subject. If you're not happy with the dev's implementation you can set it explicitly. Assuming the pronouns are he,him,his, the examples in order would be pronouns that fit "he is a cat", "it's him, the cat", "it's his cat". </td></tr>
  <tr><td colspan="7">Body characteristics</td></tr
  <tr> <td>tail</td> <td>none/tiny/small/average/large/huge</td> <td>NONE</td> <td>SINGLE</td> <td>tail_nub</td> <td>Tail</td> <td>Tail type.</td> </tr>
  <tr> <td>hair</td> <td>none/tiny/small/average/large/huge</td> <td>N/A</td> <td>SINGLE</td> <td>hair_long</td> <td>Hair</td> <td>Hair type.</td> </tr>
  <tr> <td>bdycoat</td> <td>fur/scales</td> <td>bdycoat_skin</td> <td>MULTIPLE</td> <td>bdycoat_fur</td> <td>Body</td> <td>Skin/fur type</td> </tr>
  <tr> <td>bdytpe</td> <td>quadruped/USER_DEFINED</td> <td>bdytpe_biped</td> <td>SINGLE</td> <td>bdytpe_quadruped</td> <td>Body</td> <td></td> </tr>
  <tr> <td>bdyfat</td> <td>none/tiny/small/average/large/huge</td> <td>bdyfat_average</td> <td>SINGLE</td> <td>bdyfat_large</td> <td>Bodyfat. Assume large = chubby and huge = obese.</td> <td></td> </tr>
  <tr> <td>bdymscl</td> <td>none/tiny/small/average/large/huge</td> <td>bdymscl_average</td> <td>SINGLE</td> <td>bdymscl_large</td> <td>Muscle amount.</td> <td></td> </tr>
  
</table>



### Tertiary Tags
Very few devs will use these due to their specificity. These can also include systems-specific tags that are only used in your particular project. Most tags will end up here. **Note: I'm going to need help expanding this list.**

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>
  
  <tr><th colspan="7">Body characteristics</th></tr>
  <tr> <td>hairclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>hairclr_black</td> <td>Hair</td> <td>Name of the color of your hair.</td> </tr>
  <tr> <td>eyeclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>eyeclr_green</td> <td>Head</td> <td>Name of the color of your eyes. If heterochromic, tag left first, then right.</td> </tr>
  <tr> <td>bdyclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>bdyclr_orange</td> <td>Body</td> <td>When tagging multiple colors, tag them in order of significance.</td> </tr>
  <tr> <td>bdy</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>bdy_tentacles</td> <td>Body</td> <td>These tags are for boolean values that should be set on your avatar. Such as bdy_tentacles, bdy_fangs, bdy_claws etc.</td> </tr>
  
  
  
  <tr><th colspan="7">Clothing subtags</th></tr>
  <tr> <td>ofit</td> <td>USER_DEFINED</td> <td>NONE</td> <td>MULTIPLE</td> <td>ofit_tank top</td> <td>Outfit</td> <td>You may add multiple subtags to your ofit tags that describe a specific piece of clothing in more detail. For an example: ofit_pants_denim_tight means you're wearing pants, that are jeans and tight. The order after ofit_&lt;tag&gt;_ doesn't matter.</td> </tr>
  <tr> <td>Standard ofit subtags (prefix with ofit_):</td> <td colspan="6">
    denim, khakis, tank top, thong, sling bikini, breastplate, crotchplate, leather, metal, latex, tight, loose ... more recommendation are needed
  </td> </tr>
  
  
</table>

