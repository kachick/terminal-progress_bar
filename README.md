terminal-progress_bar
=======================

Description
------------

100% |***********************************************************************|

Features
--------

* Pure Ruby :)

Usage
-----

Try below senario and yor imaginations on REPL(irb/pry).

### Setup

```ruby
require 'terminal/progressbar'
```

### Flexible handling

```ruby
Terminal::ProgressBar.run mark: '*' do |bar|
  50.times do
    sleep 0.1
    bar.increment!
  end
  bar.pointer = 15
  bar.flush
  sleep 2

  30.times do
    sleep 0.1
    bar.increment! 2
  end

  30.times do
    sleep 0.1
    bar.decrement! 2
  end

  bar.pointer = 70
  bar.flush
  sleep 2
end
```

### Auto printing under declared interval

```ruby
Terminal::ProgressBar.auto 0.2, mark: '*' do |bar|
  50.times do
    sleep 0.1
    bar.increment
  end

  sleep 0.1
  bar.pointer = 15

  30.times do
    sleep 0.1
    bar.increment
  end
end
```

Requirements
-------------

* Ruby - [1.9.2 or later](http://travis-ci.org/#!/kachick/terminal-progress_bar)
* [optionalargument](https://github.com/kachick/optionalargument) - 0.0.3

Install
-------

```bash
$ gem install terminal-progress_bar
```

Build Status
------------

[![Build Status](https://secure.travis-ci.org/kachick/terminal-progress_bar.png)](http://travis-ci.org/kachick/terminal-progress_bar)

Link
----

* [code](https://github.com/kachick/terminal-progress_bar)
* [API](http://kachick.github.com/terminal-progress_bar/yard/frames.html)
* [issues](https://github.com/kachick/terminal-progress_bar/issues)
* [CI](http://travis-ci.org/#!/kachick/terminal-progress_bar)
* [gem](https://rubygems.org/gems/terminal-progress_bar)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.

