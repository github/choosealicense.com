# Choose a License Web Site

Like a Choose Your Own Adventure site, but only much less interesting.

# Intro

A lot of repositories on GitHub.com don't have a license. GitHub provides
a license chooser, but if you don't know anything about licenses, how are you 
supposed to make an informed decision.

ChooseALicense.com is designed to help people make an informed decision about 
licenses. 

# Immediate Goals

* Politics Free - Let's just not get into it.
* Well designed, but that goes without saying.
* The homepage should have just enough to help 99% of folks make a decision.
* For the 1%, the site will contain a list of licenses common for specific 
communities and situations.
* Not comprehensive. Seems like an odd goal, but there are a bajillion 
(I counted) licenses out there. We're going to have to filter that down to a 
small list of those that matter.

# Run It On Your Machine

1. `git clone https://github.com/github/choosealicense.com`
2. `cd choosealicense.com`
3. `script/bootstrap`
4. `script/server`
5. Open [localhost:4000](http://localhost:4000) in your favorite browser

# Adding a license

Licenses sit in the `/licenses` folder as markdown (`.md`) files. Each license has YAML front matter describing the license's properties. The body of the markdown file should be the text of the license. The available metadata fields are:

* `title` - The name of the license
* `layout` - This should be `license`
* `permalink` - The absolute URL to the license, beginning with `/licenses/`
* `source` - URL to the license source text
* `note` - The note field in the sidebar (optional)
* `how` - How to use the license, also in the sidebar
* `required`, `permitted`, `forbidden` - bulleted list of rules applicable to the license (see below)
* `filename` - The filename to be created on GitHub.com when a repository is initialized with this license.

The licenses on choosealicense.com are regularly imported to GitHub.com to be used as the list of licenses available when creating a repository. When we create a repository, we will replace certain strings in the license with variables from the repository. These can be used to create accurate copyright notices. The available variables are:

* `[fullname]` - The full name or username of the repository owner
* `[login]` - The repository owner's username
* `[email]` - The repository owner's primary email address
* `[project]` - The repository name
* `[description]` - The description of the repository
* `[year]` - The current year

# Rules 

* Rules (the license's properties) are stored as a bulleted list within the licenses YAML front matter. A full list of rules can be found in the repository's `_config.yml` file. Each rule has a name e.g., `include-copyright-source`, a human-readable label, e.g., `Copyright inclusion`, and a description `Include the original copyright with the code`. To add a new rule, simply add it to config.yml and reference it in the appropriate license. 

# License

The content of this project itself is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US), and the underlying source code used to format and display that content is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php). 
