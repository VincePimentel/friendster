# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
  * User has_many Posts
  ```
  user = User.first
  user.posts.first.content #=> "Hello!"
  ```

- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
  * Post belongs_to User
  ```
  post = Post.first
  post.user.first_name #=> "Vince"
  ```

- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
  * User(Friend) has_many Friends(User) through Friendships
  * Friend(User) has_many Users(Friend) through Friendships
  * User is self-referencing via "Friend" class

- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
  * User has_many Commented_Posts through Comments, source: "Post"
  * Post has_many Commenters through Comments, source: "User"  
  ```
  vince = User.first #=> #<User id: 1, first_name: "Vince">
  post = vince.posts.build(content: "Rails for Dummies")
  post.save
  
  alice = User.second #=> #<User id: 2, first_name: "Alice">
  comment = post.comments.build(user_id: alice.id, content: "This post was helpful, thanks!")    
  comment.save
  
  alice.commented_posts #=> [#<Post id: 1, content: "Rails for Dummies", user_id: 1>]
  alice.comments #=> [#<Comment id: 1, content: "This was very helpful, thanks!", post_id: 1, user_id: 2>]
  
  post.commenters #=> [#<User id: 2, first_name: "Alice">]
  post.comments #=> [#<Comment id: 1, content: "This was very helpful, thanks!", post_id: 1, user_id: 2>]
  ```  

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
  * User has_many Commented_Posts through Comments, source: "Post"
  * Post has_many Commenters through Comments, source: "User" 
  ```
                                               |------user-submittable attribute-------|  |----foreign keys----|
  comment = Comment.first #=> #<Comment id: 1, content: "This was very helpful, thanks!", post_id: 1, user_id: 2>
  comment.content #=> "This was very helpful, thanks!"
  ```

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  * User (presence of: `first_name`, `last_name`, `username`, `email`, `password`, `password_confirmation`)
  * Post (custom validations for: `content`)
  * Comment (presence of: `content`)
  * Friendship (presence of: `relationship`)
  
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  * User (`User.friendliest`)
  * Post (`Post.trending`)
  * `/top`
  
- [x] Include signup (how e.g. Devise)
- [x] Include login (how e.g. Devise)
- [x] Include logout (how e.g. Devise)
- [ ] Include third party signup/login (how e.g. Devise/OmniAuth)
- [ ] Include nested resource show or index (URL e.g. users/2/recipes)
- [ ] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
