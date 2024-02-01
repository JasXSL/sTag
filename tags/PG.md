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
  <tr> <td>pnoun</td> <td>he,him,his / she,her,her / USER_DEFINED</td> <td>DEVELOPER_DEFINED</td> <td>SINGLE</td> <td>pnoun_he,him,his</td> <td>Body</td> <td>Most users can omit this tag. The default value is left up to individual devs, because I'm not touching this subject. If you're not happy with the dev's implementation you can set it explicitly. Assuming the pronouns are he,him,his, the examples in order would be pronouns that fit "he is a cat", "it's him, the cat", "it's his cat". </td></tr>
  <tr><td colspan="7">Clothing. Tagging your clothing is relatively important as otherwise NPCs and scripts may think you're naked! The </td></tr>
  <tr> <td>ofit</td> <td>USER_DEFINED</td> <td>NONE</td> <td>MULTIPLE</td> <td>ofit_pants</td> <td>Outfit</td> <td>The Primary outfit tag should contain generalized information about your outfit, but you don't need to go overboard. The values below are standardized. Note: There is also a Tertiary outfit tag with more granual data.</td> </tr>
  <tr> <td>Standard Primary outfit values (prefix with outfit_):</td> <td colspan="6">
    underpants (includes bikini bottoms/thongs/swimtrunks etc), skirt, dress, bodysuit, bra (includes bikini tops), shirt, jacket, armor, swimsuit, leggings, gloves, glasses, hat. <b>Note: I'll need help expanding this</b>
  </td> </tr>
</table>



### Secondary Tags
These are tags that many developers will incorporate to add some depth to their systems, but aren't as important as primary tags. For guidance, what are the immediate characteristics that jump to your mind the moment you see an avatar?

<!-- 
  <tr> <td>category</td> <td>value</td> <td>default</td> <td>quant</td> <td>ex</td> <td>point</td> <td>expl</td> </tr> 
-->

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>
  
  <tr><td colspan="7">Body characteristics</td></tr
  <tr> <td>tail</td> <td>none/tiny/small/average/large/huge</td> <td>NONE</td> <td>SINGLE</td> <td>tail_nub</td> <td>Tail</td> <td>Tail type.</td> </tr>
  <tr> <td>hair</td> <td>none/tiny/small/average/large/huge</td> <td>N/A</td> <td>SINGLE</td> <td>hair_long</td> <td>Hair</td> <td>Hair type.</td> </tr>
  <tr> <td>bdycoat</td> <td>fur/scales</td> <td>bdycoat_skin</td> <td>MULTIPLE</td> <td>bdycoat_fur</td> <td>Body</td> <td>Skin/fur type</td> </tr>
  <tr> <td>bdyclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>bdyclr_orange</td> <td>Body</td> <td>When tagging multiple colors, tag them in order of significance.</td> </tr>
  <tr> <td>bdytpe</td> <td>quadruped/USER_DEFINED</td> <td>bdytpe_biped</td> <td>SINGLE</td> <td>bdytpe_quadruped</td> <td>Body</td> <td></td> </tr>

</table>



### Tertiary Tags
Very few devs will use these due to their specificity. These can also include systems-specific tags that are only used in your particular project. Most tags will end up here. **Note: I'm going to need help expanding this list.**

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>
  
  <tr><th colspan="7">Body characteristics</th></tr>
  <tr> <td>hairclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>hairclr_black</td> <td>Hair</td> <td>Name of the color of your hair.</td> </tr>
  <tr> <td>eyeclr</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>eyeclr_green</td> <td>Head</td> <td>Name of the color of your eyes. If heterochromic, tag left first, then right.</td> </tr>
  <tr> <td>hnd</td> <td></td> <td>N/A</td> <td>MULTIPLE</td> <td>hnd_claws</td> <td>Body/hands</td> <td>See below for standard values</td> </tr>
  <tr><td>Syntax: value:default</td><td colspan="6">claws:NONE, 4fingers:5fingers, 3fingers:5fingers</td></tr>
  <tr> <td>bdycat</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>bdycat_mobian</td> <td>Body</td> <td>Can be used to denote artistic style of your body. Such as "my little pony", "anime" etc.</td> </tr>
  
  
  <tr><th colspan="7">Clothing</th></tr>
  <tr> <td>outfit</td> <td>USER_DEFINED</td> <td>NONE</td> <td>MULTIPLE</td> <td>outfit_tank top</td> <td>Outfit</td> <td>The Tertiary outfit tag should contain specific information about your outfit. The values below are standardized.</td> </tr>
  <tr> <td>Standard Secondary outfit values (prefix with outfit_):</td> <td colspan="6">
    jeans, khakis, tank top, thong, sling bikini, breastplate, crotchplate
  </td> </tr>
  <tr> <td>Note: if you wish to include a material, you may do so by appending <code>_&lt;material&gt;</code> to the tag. This goes for the Secondary outfit tags too, ex <code>outfit_pants_leather</code> or <code>outfit_breastplate_steel</code>:</td> <td colspan="6">
    jeans, khakis, tank top, thong, sling bikini... todo: suggest more standard options here
  </td> </tr>
  
  
</table>

