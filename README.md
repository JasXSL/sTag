# sTag
sTag (or stag) is a specification for adding metadata to your Second Life avatars. This is done by adding tags to your attachment descriptions. Should your attachments be no-mod, you can wear an invisible prim with tags on it.

# Background
Since Linden Labs added llGetAttachedList, scripts are now allowed to sweep an avatar's (non-HUD) attachments. This means that you can read descriptions synchronously from attachments, which in turns means that you can now add metadata that describes your avatar. This can be used to tell NPCs and other scripts some information about your avatar. For an instance, imagine if an NPC in your roleplay can react based on your appearance, such as gender or species. JasX products are planned to support this system, but the specification is open and anyone may use and modify it freely. I'd love to see some user input!

We picked the double and single dollar-separated syntax because of the free JasX creative commons mesh libraries that have been spreading throughout the grid for the past 5-6 years or so. A lot of meshes out there will already be tagged using the $$ syntax with things like tFS$WOOD to denote that said prim should generate footstep sounds when walked over (as implemented by GoThongs and xMod).

# Specification

- A tag consists of two parts separated by an underscore: `<category>_<value>` - For example: species_fox or species_human
- A category may have underscores of its own to denote one or more subcategories, for example: hair_color_black, or hair_length_short
- Each category may be specified to be present ONE or MULTIPLE times. For an instance, species_ may only be set once, whereas fur_color_ may be present multiple times for multi-colored avatars.
- A category may have a default value, specified in the tag list. For example, if species_ is not set, then the script should assume that the species is human.
- A value may contain a set of data separated by commas, for example: pronouns_he,him,his - Which is an ordered list.
- The official tag list is separated into two sections: PG and Adult. PG tags should be used by everyone, but don't expect Adult tags to be present unless your content is adult-oriented.
- Tags and values may only include lowercase alphanumeric characters and spaces.
- Each section's official tags list is separated into three categories based on importance: 
  - Primary: These are tags you absolutely SHOULD use. They relay the most widely used information, and scripters should take these into consideration when designing their systems. Things like avatar sex & species.
  - Secondary: These are tags that are recommended, but aren't as important as primary. These are things like whether your avatar has fur, hair, a tail etc.
  - Tertiary: These are very specific tags that are of very limited use to most developers, or are specific to your implementation. It can include things like whether your avatar has nails/claws, is wearing an eyepatch etc.
- Tags are stored in the object description using the syntax `TAG$<tag1>$<tag2>...`
- You may use an exclamation mark to set the category for all tags that follow: `TAG$!fur_color$red$white` is the same as typing `TAG$fur_color_red$fur_color_white`
  - The exclamation mark CHANGES the category, it does not append: `TAG$!fur_color$red$white$!tail$length_long$fur` is the same as `TAG$fur_color_red$fur_color_white$tail_length_long$tail_fur`
  - To exit out of a category you may use a single ! entry: `TAG$!fur_color$red$!$species_fox` is the same as `TAG$fur_color_red$species_fox`
- If you want to add other data to the description you may separate the tag block with $$ - For example: `myCustomDescriptionData$$TAG$species_fox$$some more custom description`. In essence, the parser will split the description by $$ and check each slice for TAG$ 

# User setup

1. The simplest way is to edit the description of the body part or clothing you want to tag. That way you know you have the correct tags whenever you wear that avatar or outfit. 
  - If your attachment is no-mod, I recommend adding and wearing an invisible object alongside that body part or piece of clothing with the same name except _tags appended to it. Note that an attachment that shows as no-mod in your inventory may actually be editable when rezzed in world.
  - The tagging system only works for root prims, not for links.
  - If you are actively wearing the object you're modifying, you will need to right click it from your inventory and set the description from the object properties, otherwise the description won't save. You will also need to re-attach said attachment or relog for the in-world description to update.
2. Type in your tags. For an instance, if you're wearing a female fox body, you could edit it and set the description to `TAG$sex_female$spec_fox`.
3. For a very basic setup, that's all you need to do. Since avatar sex and species are by far the most important tags for developers. However, if you want to get more in depth, you should check out the [PG Tag List](/tags/PG.md). And if you want to get a bit more lewd, check out the [Adult tag extension](/tags/Adult.md).

### Writing tags quick start guide:

1. Start by going through the [list](/tags/PG.md).
2. I'm going to use my female thiccfox avatar for this example. The required PG tags, at the time of writing, are: spec (species), subs (subspecies), sex, ofit (outfit). However, outfit tags are recommended to go on the outfit attachments themselves. So we'll ignore those for now and just focus on the body tags.
3. We need to start with `TAG$`, and then add tags separated by $. So to fill out the required tags we'll enter: `TAG$spec_fox$subs_vulpine$sex_female`. That's all we need to be compliant with the spec. But for the sake of completion, let's add some secondary tags too: `TAG$spec_fox$subs_vulpine$sex_female$hair_large$bdycoat_fur$bdyfat_large`. Note that if your subspecies isn't relevant, make it the same as your species. Such as `TAG$spec_human$subs_human`
4. The avatar has the tail as a separate attachment. I'll tag that up with `TAG$tail_average`
5. Finally the avatar comes with a bikini top, bottoms, and short skirt. We can set a category for these to write less by using ! - For an example, I'll tag the skirt as `TAG$!ofit$skirt$short skirt`, whcih is exactly the same as typing `TAG$ofit_skirt$ofit_short_skirt`. When you put ! before an entry it sets that entry as the category, and the tags following it will have the category prepended automatically when parsed by a script. I'll take the top as `TAG$!ofit$bra$bikini top` and the bottom as `TAG$!ofit$underpants$thong$bikini bottom`. Some of these tags are tertiary, and will rarely ever be used in actual projects, but since clothes are often on separate attachments, you have plenty of room to be detailed in your tagging.
6. **That's it! You're done!** Unless the tags you've chosen are longer than the 127 bytes allowed in SL description, or want to add adult tags. In which case read on.

### Fitting more stuff into the description

So you've run into issues where you're running out of space in your description. There are a few things you should consider doing!

- Use ! to set an active tag. As discussed above, any category that allows multiple entries (such as ofit or bdycoat) you can set a the category by prepending it with an exclamation mark. Any following tags will have that category automatically prepended. For an example: `TAG$!ofit$skirt$short skirt$!bdycoat$fur$scales` is the same as writing `TAG$ofit_skirt$ofit_short skirt$bdycoat_fur$bdycoat_scales`.
- Some values can be shortened. For an example, the values that expect none/tiny/small/average/large/huge may be shortened to their initial: n/t/s/a/l. So instead of doing `bdyfat_large` you can write `bdyfat_l`
- In the worst case scenario you can attach tags to other bodyparts. For an instance if you always use the same head with the same body, you can spread your tags between the head attachment and body attachment. Or create an invisible prim, tag it, and always wear it alongside your body.
- In our example above, we can turn `TAG$spec_fox$subs_vulpine$sex_female$hair_large$bdycoat_fur$bdyfat_large` into `TAG$spec_fox$subs_vulpine$sex_female$hair_l$bdycoat_fur$bdyfat_l`

### Adult tags: Genitals

- The adult extension only has one primary tag (at time of writing): bits. This gives you more fine control over your settings, especially in JasX games that use genital flags instead of gender. Set one bits tag for each piece of genitalia relevant to your avatar. Example for female would be `TAG$bits_vagina$bits_breasts`. This can be shortened to the initials: `TAG$bits_v$bits_b`. If we add it to our body example above. The genital tags also lets you append a size tag (none/tiny/average/large/huge) like `TAG$bits_breasts_large`, and we can shorten both: `TAG$bits_b_l`. Putting it together with the rest of the body tags: `TAG$spec_fox$subs_vulpine$sex_female$hair_l$bdycoat_fur$bdyfat_l$!bits$b_l$v`.
- For secondary tags we'll add a butt tag `butt_large` (shortened to `butt_l`). `TAG$spec_fox$subs_vulpine$sex_female$hair_l$bdycoat_fur$bdyfat_l$butt_large$!bits$b_l$v`. Note that I put it before the ! because even though you can cancel the active category by adding it with no category after it `TAG$!bits$b_l$!$butt_large`, it saves space if you put it before the first !
- That's basically it. The final shortened body description is as follows: 
  `TAG$spec_fox$subs_vulpine$sex_female$hair_l$bdycoat_fur$bdyfat_l$butt_large$!bits$b_l$v` 
  To recap, this description says that: 
  - Our species is `fox`.
  - We belong to the `vulpine` category.
  - We're female.
  - We have large (long) hair.
  - We have fur.
  - We are chubby (large body fat).
  - We have a big butt.
  - We have a vagina, and large breasts.

# Developer setup

### Using git and the firestorm preprocessor (recommended)
1. Clone the repo into your preprocessor includes folder (Such as C:\LSL)
2. Include the stag.lsl file in your project like `#include "stag/stag.lsl"`

### Manually

1. Copy the functions (and macros) you want to use from [stag.lsl](/stag.lsl).


### Usage

- **Read a specific category using a preprocessor macro (recommended): `sTag$body_coat( targ )` -> `["skin"]`**
  - Macros are recommended beacause they have any default return values built into the macro, and also limits results to 1 for tags that are set to SINGLE.
- Read a specific category (note that the category is removed from the response to save memory): `list tags = sTagAv(uuid, "fur", [], 0);` -> `["orange","white","black"]`
- Read a specific category and provide a default response: `list tags = sTagAv(uuid, "body_coat", ["skin"], 0);` -> `["skin"]`
  - Note that the default value is returned verbatim. See the [PG Tag List](/tags/PG.md) for expected default values by category.
- Read ALL tags from an avatar (not recommended, may be very memory intensive): `list tags = sTagAv(uuid, "", [], 0)` -> `["species_fox","fur_orange","fur_white","fur_black"]`
- Note: The sTagAv is setup as `list sTagAv( key uuid, string category, list defaults, integer max_results )`


