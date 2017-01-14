# Creating a blog with Elixir and Phoenix.

## Setting up the Environment
The first thing I do when beginning to develop with a new language is check to
see if the have a version manager. Like Ruby, Python, and  Node.js, Elixir is no
different, [kiex](https://github.com/taylor/kiex) is a stripped down version manager. 

To install, run

```
$ \curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash
-s
```

Before you are able to use kiex you will have to re-source your .zshrc or
equivalent .bashrc file.
I use a dotfile versioning and management systems, thanks thoughbot!
[dotfiles](https://github.com/thoughtbot/dotfiles).

In my case, I ran

```
$ echo test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex" >
~/.zshrc.local
```

Next you can list known elixir versions using

```
$ kiex list known
```

At the writing of this post Elixir 1.4.0 has just been released, so we will use
that.

```
$ kiex install 1.4.0
```

Now kiex will tell you what to do,

```
$ source $HOME/.kiex/elixirs/elixir-1.4.0.env
```

Check your elixir version,

```
$ elixir -v
```

If all is well let's continue.

## Installing Phoenix

Time to install phoenix.

*I encourage you to go checkout the excellent (phoenix
documentation)[http://www.phoenixframework.org/docs/installation].*

Run this command to install. We will curl the most recent phoenix archive.

```
$ mix archive.install
https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
```

`mix` is Elixir's build tool. See more about is
[here](http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)

If there were no errors, run `$ mix phoenix.new -v` and check with [phoenix
releases](https://github.com/phoenixframework/phoenix/releases) to make sure
your phoenix version makes sense.

At the time of writing my version was `1.2.1`.

## Creating the project

Now we can create our project. This is were things can get interesting...

By default phoenix uses node.js library brunch.io for it's asset pipeline. I
will be sticking with the defaults, so lets do that.

If you do not have Node.js installed on your machine, go [here](node_js-and-nvm.md) for instruction on
how to setup NVM and node.js

If you have node.js and nvm installed and node, I am using the current stable
version of node.js, 7.4.0

```
$ nvm use 7.4.0
```

Before you `mix` the new project let's install install brunch.io,

```
$ npm install brunch -g
```

The `-g` flag installs brunch globally.

Now let's mix the new phoenix project.

```
mix phoenix.new si_blog
```

*If you ran into errors (like I did) with brunch or deps.get*
Enter your newly created project directory, in my case,

```
$ cd si_blog
$ mix deps.get
```

Once the dependencies are installed, enter the following command (that is likely
what appeared at the end of the phoenix project creation),

```
$ npm install && node_modules/brunch/bin/brunch build
```

If there aren't any errors you should now be able you run your server!

```
$ mix phoenix.server
```

Congrats! You can see your server in action by navigating to `127.0.0.1:4000` in
your browser.

*Don't worry about the DBConnection errors you will be seeing. We haven't set up
the Postgres database yet. That's next!*

Go [here](postgres_dev_setup_on_mac.md) to setup postgres on macOS if you haven't already.

## VERSION.

Now that we have our app setup, we have to version it.
I will be using github.

Initialize the repository,

```
$ git init
```

Now we will go to [GitHub.com](https://github.com) and create a repository where
our code will live. Then follow the instructions on github once the repository
is created.

```

```

## Configuring the DB

Now that you have your PostreSQL database setup. 
(you can make sure the service is running if you are using *brew services* with
`brew services list | grep postgresql`)


