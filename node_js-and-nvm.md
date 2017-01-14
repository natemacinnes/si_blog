# Setting up Node.js

This is a short walkthrough for setting up (node.js)[https://nodejs.org/en/] versioned with
(NVM)[https://github.com/creationix/nvm
].

First things first, let us install the Node Version Manager (NVM).

```
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh |
bash
```

Re-source you shell. In my case I am using ZSH,

```
$ source ~/.zshrc
```

or if you are using bash,

```
$ source ~/.bashrc
```

Now we can install various versions of node. For example we can list all the
lts (long term support) versions,

```
$ nvm ls-remote --lts
```

Then you can install using `$ nvm install x.x.x` (x.x.x being the version you
want.) In my case i just wanted the latest stable version.

```
$ nvm install stable
```

At the time of writing the latest stable version was `7.4.0`

Once the installation is complete you can use the verions you just installed by
entering the command,

```
$ nvm use 7.4.0
```

Check that you have correctly installed node by entering,

```
$ node -v
# v7.4.0
```

Congrats, happy JSing.
