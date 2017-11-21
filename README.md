# EM Onsite App

TO DO:

* Hide API key - DONE
- Heroku has place to store API keys
- most servers have a specific key store
* Datetime Formatting - DONE

* Log in pages
-- add 'onsite app' header - DONE
* Organization page - DONE
* Events page - DONE

** UPDATE THE FOLLOWING ONCE ORG & EVENT IS SELECTED ** - DONE

* Enable/Disable P&F
-- Surveys (surveys and session feedback) - DONE
- bug, is out of sync with exp manager Settings > hide survey checkbox
- figure out how to display flashes/error messages if request fails - DONE

* Send alert page
-- refactor for url structure change
-- add in all form fields

* Change back button to event#show with hamburger icon
* Contact Support!!!!
* Go To App
* Live Polls & Ask a Question
* Error handling
- be more specific in errors
- styling
* Add attendee
* Styling
* Deployment

Stretch
* If using AJAX..Log in flow - must store EM cookie for use on every page
-- review how cookie is set and stored across rails app
-- EM cookie now stored in rails session hash

-- how to include this value in JS files?
-- make AJAX call to own server to return cookie
-- retrieve cookie using jQuery
https://stackoverflow.com/questions/15351911/rails-store-a-cookie-in-controller-and-get-from-javascript-jquery
* configure HTTParty requests to verify SSL cert correctly
(current all set to false)
* Search for sessions

Using Open API
* Delete sessions
* Add sessions - Done
* Edit sessions - Done

Using Internal API
* Store cookie - Done
* Send as a header to an internal API endpoint - Done
* Log in and receive cookie - Done
* Send Alert - Done
-- sending null values?! "scheduled_date": null
-- setting it to nil, will parse into null with .json

Questions
* Sometimes requests take a LONG time or fail
* Connection Header??
