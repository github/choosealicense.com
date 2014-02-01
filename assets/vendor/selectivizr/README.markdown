Selectivizr
-----------

**CSS3 selectors for IE**


_selectivizr_ is a JavaScript utility that emulates CSS3 pseudo-classes
and attribute selectors in Internet Explorer 6-8. Simply include the
script in your pages and selectivizr will do the rest.

To use the library, you'll need to include one of the supported libraries:

  * jQuery (1.3+/1.4+)
  * Dojo (1.5.0+)
  * Prototype (1.6.1+)
  * Yahoo UI Library (2.8.0+)
  * DOMAssistant (2.8.0+)
  * MooTools (1.3+)
  * NWMatcher (1.2.3+)
  
Then add the following conditional comment:

	<!--[if (gte IE 6)&(lte IE 8)]>
	  <script type="text/javascript" src="selectivizr.js"></script>
	  <noscript><link rel="stylesheet" href="[fallback css]" /></noscript>
	<![endif]-->

This adds the `selectivizr.js` and fallback CSS file to IE6-8 while hiding
for other browsers.