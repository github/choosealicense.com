# Choosealicense.com

[![Build Status](https://travis-ci.org/github/choosealicense.com.svg?branch=gh-pages)](https://travis-ci.org/github/choosealicense.com)

Like a Choose Your Own Adventure site, but only much less interesting.

## Intro

A lot of repositories on GitHub.com don't have a license. GitHub provides a license chooser, but if you don't know anything about licenses, how are you supposed to make an informed decision?

[ChooseALicense.com](http://www.choosealicense.com "Choose A Licence website") is designed to help people make an informed decision about licenses by demystifying license choices through non-judgmental guidance.

## Immediate Goals

* Non-judgmental. Our goal is to help you find a license that meets *your* goals.
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

For information on adding a license, see [the CONTRIBUTING file](https://github.com/github/choosealicense.com/blob/gh-pages/CONTRIBUTING.md#adding-a-license).

## License metadata

Licenses sit in the `/_licenses` folder. Each license has YAML front matter describing the license's properties. The body of the file contains the text of the license in plain text. The available metadata fields are:

#### Required fields

* `title` - The license full name specified by http://spdx.org/licenses/
* `spdx-id` - Short identifier specified by http://spdx.org/licenses/
* `source` - The URL to the license source text
* `description` - A human-readable description of the license
* `how` - Instructions on how to implement the license
* `using` - A list of 3 notable projects using the license with straightforward LICENSE files which serve as examples newcomers can follow and that can be detected by [licensee](https://github.com/benbalter/licensee) in the form of `project_name: license_file_url`
* `permissions` - Bulleted list of permission rules
* `conditions` - Bulleted list of condition rules
* `limitations` - Bulleted list of limitation rules

#### Optional fields

* `featured` - Whether the license should be featured on the main page (defaults to false)
* `hidden` - Whether the license is neither [popular](https://opensource.org/licenses) nor fills out the [spectrum of licenses](http://choosealicense.com/licenses/) from strongly conditional to unconditional (defaults to true)
* `nickname` - Customary short name if applicable (e.g, GPLv3)
* `note` - Additional information about the licenses
* `redirect_from` - Relative path(s) to redirect to the license from, to prevent breaking old URLs

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

#### Permissions

* `commercial-use` - This software and derivatives may be used for commercial purposes.
* `modifications` - This software may be modified.
* `distribution` - This software may be distributed.
* `private-use` - This software may be used and modified in private.
* `patent-use` - This license provides an express grant of patent rights from contributors.

#### Conditions

* `include-copyright` - A copy of the license and copyright notice must be included with the software.
* `document-changes` - Changes made to the code must be documented.
* `disclose-source` - Source code must be made available when the software is distributed.
* `network-use-disclose` - Users who interact with the software via network are given the right to receive a copy of the source code.
* `same-license` - Modifications must be released under the same license when distributing the software. In some cases a similar or related license may be used.
* `same-license--file` - Modifications of existing files must be released under the same license when distributing the software. In some cases a similar or related license may be used.
* `same-license--library` - Modifications must be released under the same license when distributing the software. In some cases a similar or related license may be used, or this condition may not apply to works that use the software as a library.

#### Limitations

* `trademark-use` - This license explicitly states that it does NOT grant trademark rights, even though licenses without such a statement probably do not grant any implicit trademark rights.
* `liability` - This license includes a limitation of liability.
* `patent-use` - This license explicitly states that it does NOT grant any rights in the patents of contributors.
* `warranty` - The license explicitly states that it does NOT provide any warranty.

## License

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code used to format and display that content is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
