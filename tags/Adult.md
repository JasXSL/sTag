### Warning: This is an appendix of adult-specific tags. These are only useful if you're making an adult project. See the PG sheet for the major list of tags.

Legend:
- Category: The tag category. Tags follow the syntax `<category>_<value>`
- Value: The tag value.
  - USER_DEFINED: The value can be anything defined by the user. If used on a category with quant type MULTIPLE, enter them in order of most to least significant. For an instance, fox fur may be dominant orange, then white, then black. You'd do something like `TAG$!body_color$orange$white$black`, letting devs know that orange is the most significant color.
  - X/Y/Z : The value can be one of these. Note that many of these may be subject to interpretation. Just make an estimate and it'll work out!
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
These are tags that most users SHOULD use. If you add any tags at all, add these.

<table>
 
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Comment</th></tr>

  <tr> <td>bits</td> <td>vagina/breasts/penis</td> <td>N/A</td> <td>MULTIPLE</td> <td>bits_breasts</td> <td>Body</td> <td></td> </tr>
  <tr><td colspan="7">You may additionally append <code>_<size></size></code> to the breasts/penis tags to denote size. Viable size values are <code>tiny/small/average/large/huge</code>. Ex: <code>bits_breasts_large</code>. Devs can check for the presence of bits_breasts for existence.</td></tr>

</table>


### Secondary Tags
These are tags that many developers will incorporate to add some depth to their systems, but aren't as important as primary tags. For guidance, what are the immediate characteristics that jump to your mind the moment you see an avatar?

<!-- 
  <tr> <td>category</td> <td>value</td> <td>default</td> <td>quant</td> <td>ex</td> <td>point</td> <td>expl</td> </tr> 
-->

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Comment</th></tr>

  <!--
  <tr><td colspan="7">Body characteristics</td></tr>
  <tr> <td>breast_size</td> <td>tiny/small/average/large/huge</td> <td>N/A</td> <td>SINGLE</td> <td>breast_size_large</td> <td>Body</td> <td>Do not rely on breasts being present if this tag is set, always check for the bits tag first!</td> </tr>
  -->
  
  <tr><td colspan="7">Clothing</td></tr>
  <tr> <td>This is an extension of the outfit category in PG:</td> <td colspan="6">
    restraints, gag, groin exposed, breasts exposed, butt exposed (if your clothing leaves certain parts exposed, such as a jockstrap)
  </td> </tr>
  
</table>



### Tertiary Tags
Very few devs will use these due to their specificity. These can also include systems-specific tags that are only used in your particular project. Most tags will end up here. **Note: I'm going to need help expanding this list.**

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>

  <!--
  <tr><td colspan="7">Body characteristics</td></tr>
  <tr> <td>hair_color</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>hair_color_black</td> <td>Hair</td> <td>Name of the color of your hair.</td> </tr>
  -->
  
  <tr><td colspan="7">Clothing</td></tr>
  <tr> <td>Todo: Extend the PG tertiary list with adult stuff:</td> <td colspan="6">
    What do you suggest?
  </td> </tr>
  
  
</table>


