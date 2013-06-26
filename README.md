[![Build Status](https://travis-ci.org/dontmitch/group_planning.png?branch=master)](https://travis-ci.org/dontmitch/group_planning)
#grouPACT
###Group planning, conditionally.
---

A Rails based web application featuring algorithmic background jobs, mailer integration and Stripe authentication and payment processing. Built by a team of three over the course of eight days, this app required knowledge of the full development stack.

We made heavy use of GitHub for version control, Asana for group planning and task management, and RSpec and Capybara testing for quality control.

This application attempts to solve the problem of wavering commitments from friends when it comes to planning group events. By allowing invitees to explicitly state under what conditions they will attend an event - and then compute whose conditions were ultimately met - the app frees the event planner from the need to track down and otherwise heckle their friends.

![grouPACT Screenshot](/images/groupact_screenshot.png)

Check out the live website at [grouPACT.me](http://groupact.me). Note that currently the payments functionality is set to 'test'. No real money will be transfered!

Note: Travis tests are most likely failing due to lack of support for js-based rspec testing.