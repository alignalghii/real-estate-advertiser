 - Router/controller, models etc: make difference between error and log
 - Testing: unit tests in addition to webtest
 - In the database, the `id` values do not coincide necessarily with 1...COUNT-1 ranges, they may go higher, leaving holes. The Model whwn using GET params should not go wrong!
 - In URLs, write `&amp;` instead of the `&`-sign, as latter is a sensitive character, while the usage of the ampersand HTML-entity is safer
 - Also the overview page should be able to take GET-parameter `i` for image pointer. While the page itself does not show it explicity, it should remember it for the case of jumping to details.
 - Also the overview page can change explicitly for the `i` picture index: the seletion of the two medium pictures shoul depend on it.
 - Details page has also a timed event to return to the overview page, not only the explicit linking back.
 - Error pages should provide explanation, at least in the development version.
 - Later, on error pages, make difference between user-visible conseiling vs developer-used logging.
 - Only blur/make faint unused navigation buttons Prev/Next, do not it missing completely. (`webtest.bash` must be adjusted accordingly.)
 - Error pages should have paramers (p, n, i) to be able to return to the caller/triggerer page
 - Parameter `p` is defaulted to overview, `n` and `i` parameters are defaulted to 1. The latter two defaultings can be probelmatic when the database is not yet loaded.
 - The viewmodels of controllers Overview and Details are unnecessarily complicated, they should be trimmed.
 - Check HTML validness with `lint`, also do SEO, at least give all images an `alt` description.
 - Images: instead of small-small-big-small-small, it should be big-NEWDIV-small-small-raisedsmall-small-small
 - In script `webtest.bash`, all labels `' - OK'` should be corrected: `' + OK'`
 - Use HTML5's specific tags as `navigation` instead of `<div class="navigation">`
 - Optimize/simplify/unify CSS for horizontal menu/icon lists: they are implemented twice, once for menu (`navigation.css`: `class="navigation"`), second for icon lists (`gallery.css`: `class="icon-line"`).
 - Better order for navigation icons: overview (prev, next, round, details), details (prev, next, -SPACE-, back-to-overview).
 - Refactor `webtest.bash`: remove redundancy, use loops, (associative) arrays and functions.
 - Use more portable JavaScript techniques, not too brandnew ones: `for(;;)` instead of `for/of`, and `window.location` instead of `link.click()`, maybe also rough `window.onload` instead of sophisticated imitations of `document.ready`.
 - JavaScript testing with PhantomJS, Karma
 - Type info for function (forgotten at contructors and controller methods)
 - No handling for case when database connection is OK but no tables are created yet. Also consider handling of wrong connection, or existing but empty tables.

# In cirl-grep test (`webtest.bash`)

 - Besides `low-level`, do also for `high plain-level` and `high REST-level` at the database-reinitialization-with sample-data test: the willful breaking of the database should be done not only with direct insertion and deletion, but also with high-level (plain or REST) curl-ing.
 - Replace `awk` to `gawk`

# Router (`index.php`)

 - Dispatch also by the `OPTIONS` method (see REST API)
