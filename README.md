# Choosealicense.com

[![Build Status](https://travis-ci.org/github/choosealicense.com.png?branch=gh-pages)](https://travis-ci.org/github/choosealicense.com)

Like a Choose Your Own Adventure site, but only much less interesting.

## Intro

A lot of repositories on GitHub.com don't have a license. GitHub provides a license chooser, but if you don't know anything about licenses, how are you supposed to make an informed decision?

[ChooseALicense.com](http://www.choosealicense.com "Choose A Licence website") is designed to help people make an informed decision about licenses.

## Immediate Goals

* Non-partisan. Our goal is to help you find a license that meets *your* goals.
* Well designed, but that goes without saying.
* The homepage should have just enough to help 99% of folks make a decision.
* For the 1%, the site will contain a list of licenses common to specific communities and situations.
* Not comprehensive. Seems like an odd goal, but there are a bajillion licenses out there. We're going to have to filter that down to a small list of those that matter.

## Run It On Your Machine

```bash
git clone https://github.com/github/choosealicense.com.git
cd choosealicense.com
script/bootstrap
script/server
```
Open `http://localhost:4000` in your favorite browser.

## Adding a license

Licenses sit in the `/_licenses` folder. The text of the license should be wrapped to a 78 character width. Each license has YAML front matter describing the license's properties. The body of the file should be the text of the license in plain text. The available metadata fields are:

### YAML front matter

#### Required fields

* `title` - The SPDX-compliant, human-readable license name
* `source` - The URL to the license source text
* `description` - A human-readable description of the license
* `how` - Instructions on how to implement the license
* `required` - Bulleted list of required rules
* `permitted` - Bulleted list of permitted rules
* `forbidden` - Bulleted list of forbidden rules

#### Optional fields

* `note` - Additional information about the licenses
* `using` - A list of notable projects using the license in the form of `project_name: "url"`
* `hidden` - Whether the license is hidden from the license list (defaults to false)
* `redirect_from` - Relative path(s) to redirect to the license from
* `featured` - Whether the license should be featured on the main page (defaults to false)
* `nickname` - A shorter, human-readable license name where the SPDX license name is long
* `variant` - Whether the license is a variant of a family of licenses (e.g., GPL)
* `family` - If part of a license family, the name of the license family (e.g., `GPL`)
* `tab-slug` - If part of a license family, a license slug containing only `a-z`, `0-9`, and `_` characters

### Auto-populated fields

The licenses on choosealicense.com are regularly imported to GitHub.com to be used as the list of licenses available when creating a repository. When we create a repository, we will replace certain strings in the license with variables from the repository. These can be used to create accurate copyright notices. The available variables are:

#### Fields

* `fullname` - The full name or username of the repository owner
* `login` - The repository owner's username
* `email` - The repository owner's primary email address
* `project` - The repository name
* `description` - The description of the repository
* `year` - The current year

## License properties

The license properties (rules) are stored as a bulleted list within the licenses YAML front matter. Each rule has a name e.g., `include-copyright`, a human-readable label, e.g., `Copyright inclusion`, and a description `Include the original copyright with the code`. To add a new rule, simply add it to `_data/rules.yml` and reference it in the appropriate license.

### Rules

#### Required

* `include-copyright` - Include a copy of the license and copyright notice with the code.
* `document-changes` - Indicate significant changes made to the code.
* `disclose-source` - Source code must be made available when distributing the software. In the case of LGPL and OSL 3.0, the source for the library (and not the entire program) must be made available.
* `network-use-disclose` - Users who interact with the software via network are given the right to receive a copy of the corresponding source code.
* `library-usage` - The library may be used within a non-open-source application.
* `rename` - You must change the name of the software if you modify it.

#### Permitted

* `commercial-use` - This software and derivatives may be used for commercial purposes.
* `modifications` - This software may be modified.
* `distribution` - You may distribute this software.
* `sublicense` - You may grant a sublicense to modify and distribute this software to third parties not included in the license.
* `private-use` - You may use and modify the software without distributing it.
* `patent-use` - This license provides an express grant of patent rights from the contributor to the recipient.

#### Forbidden

* `trademark-use` - While this may be implicitly true of all licenses, this license explicitly states that you may NOT use the names, logos, or trademarks of contributors.
* `no-liability` - Software is provided without warranty and the software author/license owner cannot be held liable for damages.
* `no-sublicense` - You may not grant a sublicense to modify and distribute this software to third parties not included in the license.
* `modifications` - This software may not be modified.
* `distribution` - You may not distribute this software.
* `sublicense` - You may not grant a sublicense to modify and distribute this software to third parties not included in the license.

## License

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code used to format and display that content is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
