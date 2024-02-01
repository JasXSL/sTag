Legend:
- Category: The tag category. Tags follow the syntax `<category>_<value>`
- Value: The tag value
  - USER_DEFINED: The value can be anything defined by the user.
  - X/Y/Z : The value can be one of these.
  - X,Y,Z : The value should be an ordered CSV following this pattern.
  - X,Y,Z... : The value should be an ordered CSV but has a variable amount of entries specified by the user.
- Default value: The default value that scripters should expect if the tag is not set on an avatar. If your avatar matches the default value, you should not add the tag to your avatar.
  - DEVELOPER_DEFINED : The handling of a missing tag is up to the individual developer.
  - N/A : Not applicable, or doesn't exist. If a field is N/A, the scripter should not make assumptions about the field.
- Quant: Nr of tags of this category that may exist.
  - SINGLE : Only one tag of this category may exist.
  - MULTIPLE : Multiple tags of this category may be used.
- Example: An example use of this tag.
- Recommended Point: A recommended attachment to set the tag on.
- Explanation: Explains the tag (if necessary).

### Primary Tags
These are tags that most users SHOULD use. If you set up any tags at all, set these up.

| Category | Value | Default Value | Quant | Example | Recommended Point | Explanation |
| --- | --- | --- | --- | --- | --- | --- |
| species | USER_DEFINED | human | SINGLE | species_fox | Body | Sets your avatar's species. |
| sex | male/female/USER_DEFINED | N/A | SINGLE | sex_male | Body | Sets your avatars physical sex. Note: The adult tagset has a "bits" tag which is more granular than this, and should be prioritized over this tag for adult projects. |
| pronouns | he,him,his / she,her,her / USER_DEFINED | DEVELOPER_DEFINED | SINGLE | pronouns_he,him,his | Body | Most users can omit this tag. The default value is left up to individual devs, because I'm not touching this subject. If you're not happy with the dev's implementation you can set it explicitly. Assuming the pronouns are he,him,his, the examples in order would be pronouns that fit "he is a cat", "it's him, the cat", "it's his cat". |



### Secondary Tags
These are tags that many developers will incorporate to add some depth to their systems, but aren't as important as primary tags. For guidance, what are the immediate characteristics that jump to your mind the moment you see an avatar?

| Category | Value | Default Value | Quant | Example | Recommended Point | Explanation |
| --- | --- | --- | --- | --- | --- | --- |
|  |  |  |  |  |  |  |


### Tertiary Tags
These tags are very specific, and of limited use to the general public. These can also include systems-specific tags that are only used in your particular project. Most tags will end up here.

| Category | Value | Default Value | Quant | Example | Recommended Point | Explanation |
| --- | --- | --- | --- | --- | --- | --- |
|  |  |  |  |  |  |  |

