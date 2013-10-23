# How to Contribute

We love Pull Requests! Your contributions help make ChooseALicense.com great.

## Getting Started

So you want to contribute to ChooseALicense. Great! We welcome any help we can 
get. But first, please make sure you understand what 
[this site is all about](http://choosealicense.com/about).

It’s not a comprehensive list of all possible licenses.

If you understand the goals of this site and still want to suggest a change, 
please:

* Make sure you have a [GitHub account](https://github.com/signup/free)
* Submit a ticket for your issue, assuming one does not already exist.
  * Clearly describe the issue including steps to reproduce when it is a bug.
  * Make sure you fill in the earliest version that you know has the issue.

## Making Changes

The easiest way to make a change is to simply edit a file from your browser. 
When you click the edit button, it will fork the repository under your account.
Note what issue/issues your patch fixes in the commit message.

For example, to [change this file](https://github.com/github/choosealicense.com/blob/master/CONTRIBUTING.md), 
find it in the GitHub repository. Then click the `Edit` button. Make your 
changes, type in a commit message, and click the `Propose File Change` button.
That’s it!

For more advanced changes, check out [the bootstrap instructions](https://github.com/github/choosealicense.com#run-it-on-your-machine) in the [project's readme](https://github.com/github/choosealicense.com/blob/master/README.md).

## Testing

[HTML::Proofer](https://github.com/gjtorikian/html-proofer) is set up to validate all links within the project.  You can run this locally to ensure that your changes are valid:

```shell
./script/bootstrap
./script/cibuild
```
