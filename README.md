# Brownfield Of Dreams

This is a Brownfield project completed by Zach Nager and Teresa Knowles in Mod 3 at the Turing School of Software & Design.

Project Spec and Evaluation Rubric: https://github.com/turingschool-examples/brownfield-of-dreams

### Project Board

This Project board was used to organize tasks cleaning and building on the existing code base. Tasks included those assigned by instructors and additional tasks and goals: https://github.com/teresa-m-knowles/brownfield-of-dreams/projects/1

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered (via confirmation email) a user can bookmark any of the segments in a tutorial page. A registered user can also user GitHub Oauth authorization to link their account. Once linked, they can see their repos, followers, and people who follow them. They can also follow, or be "friends", with other site users also registered with a GitHub account.

An admin user also has the ability to upload new tutorials. They can choose to initiate a tutorial by hand and upload videos individually, or create a tutorial by uploading an entire existing YouTube playlist.

## Heroku Navigation

You can visit a live version of the app at: https://desolate-cove-48498.herokuapp.com/

You can view tutorials hosted on the site without registering, or you can register an account by following the link at the top of the page. You will receive a verification email with a link to verify your account before receiving access to the 'User Dashboard'.

Once verified, you can connect your GitHub account to your account using OAuth. This will give you access to see 5 of your repositories on your dashboard, as well as a list of your Followers and who you Follow. You will also see a link to invite others to the website via an email address. This will send the user an email with an invitation to register an account with the app.

If any of your Github connections are registered with the site there will be an option to save them to your "friends" list.

You are free to navigate the site by looking at tutorials which will have a list of different videos associated with them connected to YouTube. You can bookmark a video by clicking 'Bookmark' above the video. The video title will now show in your Bookmarks on your dashboard. The bookmark function uses JavaScript to keep the page and video from refreshing when bookmarking.

Admins have the ability to make new, edit or delete tutorials. You can Log In as an admin by using:

email: admin@example.com password: password

## Local Setup

#### For testing on localhost:3000:

Clone down the repo
```
$ git clone git@github.com:teresa-m-knowles/brownfield-of-dreams.git
```

Install the gem packages
```
$ bundle install
```

Install Figaro
```
$ bundle exec figaro install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

You'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. For OAuth testing you will need a GitHub Key and Secret. Full testing will also require GitHub API keys for 2 users.

Figaro will create an application.yml in the config directory. In this file, add these secrets like this:
```
YOUTUBE_API_KEY: ExampleKey123abc
USER_1_GITHUB_TOKEN: ExampleKey123abc
USER_2_GITHUB_TOKEN: ExampleKey123abc
GITHUB_KEY: ExampleKey123abc
GITHUB_SECRET: ExampleKey123abc
```

And in the code, these are refered to like this:
```
ENV["YOUTUBE_API_KEY"]
ENV["USER_1_GITHUB_TOKEN"]
ENV["USER_2_GITHUB_TOKEN"]
ENV["GITHUB_KEY"]
ENV["GITHUB_SECRET"]
```
Run the test suite:
```ruby
$ bundle exec rspec
```

You will also need to install MailCatcher
```
$ gem install mailcatcher
```
and run
```
$ mailcatcher
```

You can run the app locally on localhost:3000:
```
$ rails s
```

### Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0


#### Team DTR
Group Member Names: Zach Nager and Teresa Knowles

Project Expectations: What does each group member hope to get out of this project? 
-Strive for 4s but make sure we have 3s all across first. 
-Gain a solid understanding of working with APIs 
-Learn Oauth 
-Learn how to squash commits and Ruby style

Goals and expectations:
-Learn more things to a good level and not just one thing very well
	
Team strengths:
-Zach: happy to put in as much time as needed, high expectations
-Teresa: trying new things, taking risks, research
Look out for:
-Zach: asking others for help
-Teresa: Tend to go into "rabbit holes" trying to have additional features

How to overcome obstacles:
-Open communication
-Honest code reviews
-Keeping an open mind
-Ask for help when needed after struggling for a while

Schedule Expectations (When are we available to work together and individually?):
-Afternoon work, no early mornings
-Review any code from the night before every morning
-Sundays off or remote day
-Saturdays are work day
-Usually we can stay at school after classes are over, 6:30-7pm. Some days Teresa will have to go home sooner

Communication Expectations (How and often will we communicate? How do we keep lines of communication open?):
-Daily over slack and in person
-Late night messages are ok but might be answered the next day

Abilities Expectations (Technical strengths and areas for desired improvement):
Improvement:
-Teresa: Using TDD as a design tool
-Zach: Use declarative programming and keep OOP principles in mind
Strengths:
-Zach: Comfortable with Active Record and Ruby
-Teresa: Comfortable with MVC and routes

Workload Expectations (What features do we each want to work on?):
-Do the setup together and then divide the workload as needed

Workflow Expectations (Git workflow/Tools/Code Review/Reviewing Pull Requests): 
-Start out working as a pair and then reasses
-Making sure we don't overlap on work 
-Be clear on what you're working on 
-Never merge your own PR
-Comment on every PR

Expectations for giving and receiving feedback:
-Open feedback
-Be real

Agenda to discuss project launch:

Ideas:
 
Tools: 
-Use Github project 
-Learn more tools (Rubocop, Hound, etc)
