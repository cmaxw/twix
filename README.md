twix
====

Twix is a command line utility for pulling down a tweet and executing
the code contained within. 

The first implementation will allow you to run something like this:

```bash
$ twix 12345
```

Where 12345 is the id of the tweet. It will execute the body of the
tweet as Ruby code. So, if Tweet #12345 has body "puts 'Hello World'"
it'll print "Hello World" to the screen.

You can also run:

```bash
$ twix @cmaxw
```

If you know that someone has recently tweeted some Ruby code you want to run, this will show the last 20 tweets that person has shared and you can choose the tweet you want to run. Something like this.

```
Tweets for @cmaxw:
	0 - Hey, don’t forget to vote for @rubyrogues today in the podcast awards. http://t.co/6BHkRXuS
	1 - p "Hi, welcome to twix, the Twitter Executor for Ruby"
	2 - RT @JSJabber: RT @JSJabber 034 JSJ Ember.js http://t.co/rZuOHT0R cc/ @trek
	3 - @chrishunt @jstorimer @saturnflyer @pat_shaughnessy If it’s within walking distance. Shall we meet up by the registration table?
	4 - OH: “Mathematicians don’t like intention revealing names” via @jimweirich at #rubyconf
	5 - @kfarris glad it helped. What’s your background? coding? sales? marketing? management?
	6 - @jstorimer @saturnflyer @pat_shaughnessy I was looking forward to a boxed lunch, but if you insist… Where should we meet?
	7 - @jwo I looked at rubycop. How it works is not immediately obvious (due partly to the lack of README.) Don’t think I want to require jruby .
	8 - @natehop Thanks, appreciate it. I love recording the shows. I also love that people enjoy listening.
	9 - So, if I wanted to write a script that downloaded a random string of code and executed it, what is the best way to do so safely?
	10 - Or, in @r00k’s case. Find an audience to heckle you.
	11 - Sitting in @r00k’s talk, it occurs to me that when they say ‘grow a pair’, they mean ‘find someone to sit with you and check your code.’
	12 - @codeodor LOL, mine’s an android phone. I’m going to upgrade it to an iPhone5. Wish me luck!
	13 - My phone won’t turn off the screen. So, it died after half a day.
	14 - Anyone up for dinner after the minitest #bof at #Rubyconf?
	15 - @martco Nice meeting you too. I hope I keep them going for a long time as well.
	16 - Had a terrific discussion with @jstorimer about ebooks, podcasts, marketing, and videos.
	17 - So, it turns out my phone is not rubyfriends friendly. Rear facing camera only with an onscreen button to take pics.
	18 - RT @blowmage: RubyConf attendees: join us tonight for a BoF session on minitest and rails4. Please RT. #rubyconf
	19 - RT @dbrady: If you are weapons-grade at ExtJS, have a passing knowledge of ruby, and have a couple weeks free (or more) please contact m ...


Which Tweet do you want to execute?
```

If you choose '1', it'll execute the tweet and print "Hi, welcome to
twix, the Twitter Executor for Ruby"

---

#ToDo
* Insert safety checks to avoid issues like running `rm -Rf /`
* Allow the user to bypass the safety checks if they're too restrictive.
* Set up a service that archives twixable tweets
* Add ability to require other tweets



