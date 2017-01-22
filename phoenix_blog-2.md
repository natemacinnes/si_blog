# Phoenix Blog 2: Creating Posts
Picking up from setting up phoenix, we can now begin creating the underlying
functionality for the blog. We will start with posts.

## Phoenix Generators
We will be utilizing phoenix generators to create the model and db migration for us along with
scaffolding for the controller and views that will be associated with it.

To do this enter this command,

```
$ mix phoenix.gen.html Post posts title:string body:text
# creating ...
# ...
# Add the resource to your browser scope in web/router.ex:
#    
#    resources "/posts", PostController
#
# Remember to update your repository by running migrations:
#    
#    $ mix ecto.migrate
#
```

For future reference, the command is sturcture in the following way: `mix phoenix.gen.html [model name] [table name] [column name:column type]`

Now following the resulting instructions from the posts genereator we need to
add the line `resources "/posts", PostsConstroller` to the `web/router.ex` file.
Add the line to the '/' scope, after the `get "/", PageController, :index line.

Now we are ready to migrate.

```
$ mix ecto.migrate
```

Now if you start the server you should be able to got to http://127.0.0.1/posts 
Playing around with it you should be able to create, edit and delete posts!

## Testing with Phoenix
Another very useful thing the phoenix generator does is create scaffolding for
tests.

You can find the created test file for Posts in `test/models/post_test.exs`.
You can find the created test files for PostsController in
`test/controllers/post_controller_test.exs`.

## Creating Users
What's a blog without users.

```
$ mix phoenix.gen.html User users username:string email:string
password_digest:string
```

Now we repeat the steps as we did for posts. Edit the `web/routes.exs` file. 
Then,

```
$ mix ecto.migrate
```



