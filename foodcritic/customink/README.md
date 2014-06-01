CustomInk Foodcritic Rules
==========================
These are the evolving foodcritic rules that we have written at CustomInk to enforce rules on our cookbooks. Some of these rules are best practices, some were put in place as remediation items, and some are just a result of [Seth Vargo's](https://github.com/sethvargo) OCD.

Usage
-----
We recommend storing all your custom foodcritic rules as a git submodule in your Chef Hosted repository. Create a folder `foodcritic` in your repository's root and `cd` into that directory:

```
git clone git@github.com:customink-webops/foodcritic-rules.git foodcritic/customink
```

Now you can run include the CustomInk foodcritic rules like so:

```bash
bundle exec foodcritic -I foodcritic/customink COOKBOOK
```

To keep this README as short as possible, each rule has its own Markdown file in the `docs` directory.

Authors
-------
- CINK001 - Seth Vargo (sethvargo@gmail.com)
- CINK002 - Seth Vargo (sethvargo@gmail.com)
- CINK003 - Seth Vargo (sethvargo@gmail.com)
