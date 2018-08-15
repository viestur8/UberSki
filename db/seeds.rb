User.create(first_name: 'Arnold',
   last_name: 'Schwarzenneger',
   email: 'arny@california.gov',
   username: 'arnoldK',
   password: 'guest',
   birthday: '07/30/1947'
 )

 User.create(first_name: 'Ray',
    last_name: 'Gillette',
    email: 'ray@isis.org',
    username: 'arnoldK',
    password: 'guest',
    birthday: '07/30/1947'
  )

Post.create(title: 'Young Snow', post: 'txt here', timestamp: 'today', user_id:1 )
