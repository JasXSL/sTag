### Warning: This is an appendix to the PG tags, containing adult-specific tags. These are only useful if you're making an adult project. See the PG sheet for the majority of the tags.

Legend:
- Category: The tag category. Tags follow the syntax `<category>_<value>`
- Value: The tag value.
  - USER_DEFINED: The value can be anything defined by the user. If used on a category with quant type MULTIPLE, enter them in order of most to least significant. For an instance, fox fur may be dominant orange, then white, then black. You'd do something like `TAG$!body_color$orange$white$black`, letting devs know that orange is the most significant color.
  - X/Y/Z : The value can be one of these. Note that many of these may be subject to interpretation. Just make an estimate and it'll work out!
  - X,Y,Z : The value should be an ordered CSV following this pattern.
  - X,Y,Z... : The value should be an ordered CSV but has a variable amount of entries specified by the user.
  - On the values listed as none/tiny/small/average/large/huge you can shorten them to n/t/s/a/l/h
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

  <tr> <td>bits</td> <td>vagina/breasts/penis/rear/testicles, v/b/p/r/t for short</td> <td>penis_none, vagina_none, breasts_none, rear_average, testicles_none</td> <td>MULTIPLE</td> <td>bits_breasts</td> <td>Body</td> <td>Devs should only check the first character of the genitals. </td> </tr>
  <tr><td colspan="7">You may additionally append <code>_&lt;size&gt;</size></code> to the all tags to denote size. Viable size values are <code>none/tiny/small/average/large/huge</code>. Ex: <code>bits_breasts_large</code> or <code>bits_b_l</code> for short. Note that testicles are assumed "average" if penis is set and testicles aren't explicitly set by the user.</td></tr>

</table>


### Secondary Tags
These are tags that many developers will incorporate to add some depth to their systems, but aren't as important as primary tags. For guidance, what are the immediate characteristics that jump to your mind the moment you see an avatar?

<!-- 
  <tr> <td>category</td> <td>value</td> <td>default</td> <td>quant</td> <td>ex</td> <td>point</td> <td>expl</td> </tr> 
-->

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Comment</th></tr>
 
  <tr><td colspan="7">Clothing</td></tr>
  <tr> <td>This is an extension of the <code>ofit_</code> category in PG:</td> <td colspan="6">
    restraints, gag, groin exposed, breasts exposed, butt exposed (if your clothing leaves certain parts exposed, such as a jockstrap)
  </td> </tr>
  
</table>



### Tertiary Tags
Very few devs will use these due to their specificity. These can also include systems-specific tags that are only used in your particular project. Most tags will end up here. **Note: I'm going to need help expanding this list.**

<table>
  
  <tr><th>Category</th><th>Value</th><th>Default Value</th><th>Quant</th><th>Example</th><th>Recommended Point</th><th>Explanation</th></tr>



  <tr><th colspan="7">Mind characteristics. Note to devs: These are purely to tailor games to users interests. They're a bit fiddly to setup, and I don't think a lot of people will go around with these publicly. But I'm leaving them in here as a tertiary tag. In addition to n/t/s/a/l/h, you can shorten entirely to e.</th></tr>
  <tr> <td>mdom</td> <td>none/tiny/small/average/large/huge/entirely</td> <td>N/A</td> <td>SINGLE</td> <td>mdom_average</td> <td>Head/Body/Dedicated preference prim</td> <td>Sets character sexual dominance, none being fully submissive, and average being a switch.</td> </tr>
  <tr> <td>mkink</td> <td>USER_DEFINED</td> <td>N/A</td> <td>MULTIPLE</td> <td>mkink_spanking_huge</td> <td>Head/Body/Dedicated preference prim</td> <td>Adds character kinks. Think of this as a public F-list. You may append a non/tiny/small/average/large/huge/entirely value based on how much you like it. For a list of kinks I'd suggest copying from f-list directly.</td> </tr>
  
  
  <tr><th colspan="7">Clothing</th></tr>
  <tr> <td>(ofit_) Todo: Extend the PG tertiary list with adult stuff:</td> <td colspan="6">
    What do you suggest?
  </td> </tr>

  
  
</table>


