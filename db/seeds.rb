User.create(first_name: 'Arnold',
   last_name: 'Schwarzenneger',
   email: 'arny@california.gov',
   username: 'arnoldK',
   password: 'guest'
   birthday:07/30/1947
 )


Blogpost.create(title: 'Young Snow', post: 'txt here', timestamp: 'today', user_id:1 )

t.string :title
t.text :post
t.timestamp :timestamp
t.integer :user_id
