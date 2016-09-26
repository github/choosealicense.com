# Choosealicense.com

[![Build Status](https://travis-ci.org/github/choosealicense.com.png?branch=gh-pages)](https://travis-ci.org/github/choosealicense.com)

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
* `permissions` - Bulleted list of permission rules
* `conditions` - Bulleted list of condition rules
* `limitations` - Bulleted list of limitation rules

#### Optional fields

* `featured` - Whether the license should be featured on the main page (defaults to false)
* `hidden` - Whether the license is neither [popular](https://opensource.org/licenses) nor fills out the [spectrum of licenses](http://choosealicense.com/licenses/) from strongly conditional to unconditional (defaults to true)
* `nickname` - Customary short name if applicable (e.g, GPLv3)
* `note` - Additional information about the licenses
* `using` - A list of up to 3 notable projects using the license with straightforward LICENSE files which serve as examples newcomers can follow and that can be detected by [licensee](https://github.com/benbalter/licensee) in the form of `project_name: license_file_url`
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
* `distribution` - You may distribute this software.
* `private-use` - You may use and modify the software without distributing it.
* `patent-use` - This license provides an express grant of patent rights from the contributor to the recipient.

#### Conditions

* `include-copyright` - Include a copy of the license and copyright notice with the code.
* `document-changes` - Indicate changes made to the code.
* `disclose-source` - Source code must be made available when distributing the software.
* `network-use-disclose` - Users who interact with the software via network are given the right to receive a copy of the corresponding source code.
* `same-license` - Modifications must be released under the same license when distributing the software. In some cases a similar or related license may be used.

#### Limitations

* `trademark-use` - This license explicitly states that it does NOT grant you trademark rights, even though licenses without such a statement probably do not grant you any implicit trademark rights.
* `no-liability` - Software is provided without warranty and the software author/license owner cannot be held liable for damages.
* `patent-use` -  This license explicitly states that it does NOT grant you any rights in the patents of contributors.

## License

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code used to format and display that content is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
