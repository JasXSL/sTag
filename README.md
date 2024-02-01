# sTag
sTag (or stag) is a specification for adding metadata to your Second Life avatars. This is done by adding tags to your attachment descriptions. Should your attachments be no-mod, you can wear an invisible prim with tags on it.

# Background
Since Linden Labs added llGetAttachedList, scripts are now allowed to sweep an avatar's (non-HUD) attachments. This means that you can read descriptions synchronously from attachments, which in turns means that you can now add metadata that describes your avatar. This can be used to tell NPCs and other scripts some information about your avatar. For an instance, imagine if an NPC in your roleplay can react based on your appearance, such as gender or species. JasX products are planned to support this system, but the specification is open and anyone may use and modify it freely. I'd love to see some user input!

We picked the double and single dollar-separated syntax because of the free JasX creative commons mesh libraries that have been spreading throughout the grid for the past 5-6 years or so. A lot of meshes out there will already be tagged using the $$ syntax with things like tFS$WOOD to denote that said prim should generate footstep sounds when walked over (as implemented by GoThongs and xMod).

# Specification

- A tag consists of two parts separated by an underscore: <category>_<value> - For example: species_fox or species_human
- A category may have underscores of its own to denote one or more subcategories, for example: hair_color_black, or hair_length_short
- Each category may be specified to be present ONE or MULTIPLE times. For an instance, species_ may only be set once, whereas fur_color_ may be present multiple times for multi-colored avatars.
- A category may have a default value, specified in the tag list. For example, if species_ is not set, then the script should assume that the species is human.
- A value may contain a set of data separated by commas, for example: pronouns_he,him,his - Which is an ordered list.
- The official tag list is separated into two sections: PG and Adult. PG tags should be used by everyone, but don't expect Adult tags to be present unless your content is adult-oriented.
- Tags and values may only include lowercase alphanumeric characters.
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
The simplest way is to 


# Developer setup

