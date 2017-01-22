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

As expected we can go to `127.0.0.1:4000/users`, not much going on there. We
can't sign in or even create a password, all we have is a password digest field.
You guessed it, that is what next, creating passwords.

### Creating Password Hashes

When we follow the `/new` action on our users page we have username, email and a
password digest field. First we are going to remove the line containing, 

```
<div class=”form-group”>
  <%= label f, :password_digest, class: “control-label” %>
  <%= text_input f, :password_digest, class: “form-control” %>
  <%= error_tag f, :password_digest %>
</div>
```

We will now add in two fields, a `:password` and `:password_confirmation` field.
It should look something like this after,
```
<div class="form-group">
  <%= label f, :password, "Password", class: "control-label" %>
  <%= password_input f, :password, class: "form-control" %>
  <%= error_tag f, :password %>
</div>

<div class="form-group">
  <%= label f, :password_confirmation, "Password Confirmation", class:
"control-label" %>
  <%= password_input f, :password_confirmation, class: "form-control" %>
  <%= error_tag f, :password_confirmation %>
</div>
```

Now we can enter the proper information on the page, but there isn't anything
creating the password digest in the user table. We still have to create that
feature.

Sounds like we need to change the User model's behaviour. This is an apportune
time to play with testing in elixir and phoenix.

### Testing User Behaviour

Head [here](http://www.phoenixframework.org/v0.13.1/docs/introduction) for more information on the test framework.

A quick start, run tests by using command, `mix test` in the root of you phoenix
project. The first time you run tests it will take a while. (It runs all the
tests in your project, including those for the included frameworks.) 
Once complete all things should pass and you can see that there already `Post`
and `User` controller tests for our project.

Test files can be found in the `test/` directory.

Go ahead and explore: `test/models/posts_test.exs`,
`test/models/users_test.exs`, `test/controllers/posts_test.exs`, `test/controllers/users_test.exs`

I don't always to test driven devlopment but when I do, I break things first.

We already know we are going to need to add the notion of a password and
password confirmation to the user model. Let's make our model users fail first.

Inside the `test/models/users_test.exs` lets change the valid attributes for the
test. Add `password: "testpass", `password_confirmation: "testpass"`

Running `mix test` now will result in our user test failing.

```
  1)  test changeset with valid attributes (Blog.UsersTest)
      test/models/user_test.exs:11
      Expected truthy, got false
      code: changeset.valid?()
      stacktrace:
        test/models/users_test.exs:13: (test)
```

Now that we broke the test, let's fix it.

Ecto has a cool feature called [virtual
fields](https://hexdocs.pm/ecto/Ecto.Schema.html). We will add both password and
password digest to the user schema.

The added fields won't be added to the database, but they will be added to our
User struct.

Head to `web/models/users.ex` and add these two fields to the user schema
block.

```
  field :password, :string, virtual: true
  field :password_confirmation, :string, virtual: true
```

And while we are in that file, let's add password and password confirmation as
validated fields.

```
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
  end
```

With these changes complete, our tests are fixed. Don't trust me? Run `mix test`
for yourself.

Ahh you got me, in fixing the model we broke our controller.
Let's head to our controller to fix our test, we want our test to test expected
behaviour.

We are going to make similar changes to our `test/controllers/users_controller_test.exs`. First lets add the `password:` and  `password_confirmation:` to the valid attributes.

```
...
  @valid_create_attrs %{email: "test@example.com", password: "testpass", password_confirmation: "testpass", username: "test_user"}
  @valid_attrs %{email: "test@example.com", username: "test_user"}
  @invalid_attrs %{}
...
```

Now we will edit our creation test,

```
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, users_path(conn, :create), users: @valid_create_attrs
    assert redirected_to(conn) == users_path(conn, :index)
    assert Repo.get_by(Users, @valid_attrs)
  end
```

That will one of the two broken tests passing, now we still have to fix the
redirect on an update.

```
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = put conn, users_path(conn, :update, users), users: @valid_create_attrs
    assert redirected_to(conn) == users_path(conn, :show, users)
    assert Repo.get_by(Users, @valid_attrs)
  end
```

Now our test should be passing again.

We added the appropriate fields for passwords, but we are still missing the
model behaviour that saves the password hash.

Let's write a test for the behaviour.

```
  test "password_digest is set to hash" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    assert get_change(changeset, :password_digest) == "IMAHASH"
  end
```

Admitedly not a greate hash, but we will add better hashing later.

Now let's make the test pass. We will add a function `hash_passowrd` to the
users model.

```
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password,
:password_confirmation])
    |> hash_password
  end

  defp hash_password(changeset) do
    changeset
    |> put_change(:password_digest, "IAMAHASH")
  end
```

Wooo, finally all the tests pass and we have our, "hashed" password. (I think we
might have a collision problem).
** Side not, single quoted things are not strings in elixir! But that is another post.** 
Now that the test introduction is complete, I will, for the most part leave the
testing and testing updates up to you.

