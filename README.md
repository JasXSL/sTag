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
  - If your attachment is no-mod, I recommend adding and wearing an invisible object alongside that body part or piece of clothing with the same name except _tags appended to it.
  - The tagging system only works for root prims, not for links.
  - If you are actively wearing the object you're modifying, you will need to right click it from your inventory and set the description from the object properties, otherwise the description won't save. You will also need to re-attach said attachment or relog for the in-world description to update.
2. Type in your tags. For an instance, if you're wearing a female fox body, you could edit it and set the description to `TAG$sex_female$species_fox`
3. For a very basic setup, that's all you need to do. Since avatar sex and species are by far the most important tags for developers. However, if you want to get more in depth, you should check out the [PG Tag List](/tags/PG.md). And if you want to get a bit more lewd, check out the [Adult tag extension](/tags/Adult.md).


# Developer setup

### Using git and the firestorm preprocessor (recommended)
1. Clone the repo into your preprocessor includes folder (Such as C:\LSL)
2. Include the stag.lsl file in your project like `#include "stag/stag.lsl"`

### Manually

1. Copy the functions (and macros) you want to use from [stag.lsl](/stag.lsl).


### Usage

- Read a specific category (recommended, note that the category is removed from the response to save memory): `list tags = sTagAv(uuid, "fur", []);` -> `["orange","white","black"]`
- Read a specific category and provide a default response: `list tags = sTagAv(uuid, "body_coat", ["skin"]);` -> `["skin"]`
  - Note that the default value is returned verbatim. See the [PG Tag List](/tags/PG.md) for expected default values by category.
- Read ALL tags from an avatar: `list tags = sTagAv(uuid, "", [])` -> `["species_fox","fur_orange","fur_white","fur_black"]`


