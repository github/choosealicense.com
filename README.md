**[ChooseALicense.com](https://choosealicense.com)** aims to provide **accurate**, **non-judgmental**, and **understandable** information about popular **open source licenses** in order to **help people make informed decisions** about the projects they start, maintain, contribute to, and use.

[![Build Status](https://travis-ci.org/t4n6a1ka/choosealicense.com.svg?branch=master)](https://travis-ci.org/t4n6a1ka/choosealicense.com)

We catalog [select](CONTRIBUTING.md#adding-a-license) open source licenses with a [Jekyll collection](https://jekyllrb.com/docs/collections/) (in `_licenses`). The catalog is used to render [ChooseALicense.com](https://choosealicense.com) and is regularly vendored into [Licensee](https://github.com/benbalter/licensee), which GitHub uses to provide a [license chooser and license detection](https://help.github.com/articles/adding-a-license-to-a-repository/), a [licenses API](https://developer.github.com/v3/licenses/), and to [display license descriptions and metadata](https://github.com/blog/2335-open-source-license-descriptions-and-metadata).

## Goals

* Be accurate, non-judgmental, and understandable. Our goal is to help you find a license that meets *your* goals.
* The homepage should have just enough to help most folks make a decision about what license to use for a project they contribute to.
* For the rest, the site will contain additional information about licenses common to specific communities and situations.
* Collaborate with and reinforce other licensing best practices and standards projects.
* Not comprehensive. Seems like an odd goal, but there are a bajillion licenses out there. We're going to have to filter that down to a small list of those that matter.

## Run It On Your Machine

```bash
git clone https://github.com/t4n6a1ka/choosealicense.com.git
cd choosealicense.com
script/bootstrap
script/server
```

Open `http://localhost:4000` in your favorite browser.

## Adding a license

For information on adding a license, see [the CONTRIBUTING file](https://github.com/t4n6a1ka/choosealicense.com/blob/master/CONTRIBUTING.md#adding-a-license).

## License metadata

Licenses sit in the `/_licenses` folder. Each license has YAML front matter describing the license's properties. The body of the file contains the text of the license in plain text. The available metadata fields are:

#### Required fields

* `title` - The license full name specified by https://spdx.org/licenses/
* `spdx-id` - Short identifier specified by https://spdx.org/licenses/
* `description` - A human-readable description of the license
* `how` - Instructions on how to implement the license
* `using` - A list of 3 notable projects using the license with straightforward LICENSE files which serve as examples newcomers can follow and that can be detected by [licensee](https://github.com/benbalter/licensee) in the form of `project_name: license_file_url`
* `permissions` - Bulleted list of permission rules
* `conditions` - Bulleted list of condition rules
* `limitations` - Bulleted list of limitation rules

#### Optional fields

* `featured` - Whether the license should be featured on the main page (defaults to false)
* `hidden` - Whether the license is neither [popular](https://opensource.org/licenses) nor fills out the [spectrum of licenses](https://choosealicense.com/licenses/) from strongly conditional to unconditional (defaults to true)
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
* `projecturl` - The repository URL or other project website

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

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 Unported license](https://creativecommons.org/licenses/by/3.0/), and the underlying source code used to format and display that content is licensed under the [MIT license](LICENSE.md).
