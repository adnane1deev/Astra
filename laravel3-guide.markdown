# Getting Started
Documentation: http://three.laravel.com/docs

# Configuration Settings and the DB
### Generate a secure application key.
1. open: project-path/application/config/application.php
2. empty the default key
3. cd project-path
4. run command bellow 
```
php artisan key:generate
```

### Set the database for the project
1. create database
2. open: project-path/application/config/database.php
3. choose database provider DEFAULT: mysql
4. set database name, password

# The Home View and the First Route
### the home view
1. project-path/application/views/home/index.blade.php

### The first route
project-path/application/routes.php

# Allow Overrides
1. open /etc/apache2/apache2.conf
2. add the following:
```
<Directory project-path/public/>
  Options Indexes FollowSymLinks MultiView
  AllowOverrides All
</Directory>
```

# Passing Variables to Views
### method-1
```php
$name = 'Adnane Boulben';
return View::make('home.about')->with('name', $name);
# or
return View::make('home.about')->with(
	array(
		'name' => $name, 
		'age' => 22)
	);
```

### method-2
```php
$name = 'Adnane Boulben';
$data = array('name' => $name, 'age' => 23);
return View::make('home.about', $data);
```

### method-3
Using magic method
```php
$name = 'Adnane Boulben';
$view = View::make('home.about');
$view->name = $name;
$view->age = 22;

return $view;
```

# Database access
### Raw queries
http://three.laravel.com/docs/database/raw
```php
# return array of objects
$posts = DB::query('select * from posts');
```
```php
# return an object
$post = DB::first('select * from posts');
```
```php
$title = 'Another title';
$body = 'Another post body';

# return boolean => insert statement
$posts = DB::query('insert into posts values(null, ?, ?)', array($title, $body));
# OR
$posts = DB::query('insert into posts values(null, :title, :body)', array($title, $body)); 
```
```php
# getting the value of a single column:
$title = DB::only('select title from posts where id = 4'); 
```

### Fluent query builder
http://three.laravel.com/docs/database/fluent
http://three.laravel.com/docs/views/pagination
```php
$posts = DB::table('posts')->first(); # return an object
$posts = DB::table('posts')->get(); # return array of objects
$posts = DB::table('posts')->get(array('title as heading', 'body as article'));
$posts = DB::table('posts')->order_by('id', 'desc')->get();
```
```php
$posts = DB::table('posts')->where('id', '!=', 1)->get('title'); # return an array of single value posts(titles)
$posts = DB::table('posts')->where('id', '!=', 1)->get(array('title as heading', 'body as article')); #specify columns 
$posts = DB::table('posts')->where('id', '!=', 1)->get(); #return array of objects
$posts = DB::table('posts')->where('id', '=', 4)->only('title as shit'); # getting the value of a single column:
$posts = DB::table('posts')->where('id', '!=', 1)
						->or_where('title', '=', 'my title')
						->get();
```
```php
/* using dynamic methods based on table columns */
$_old_posts = DB::table('posts')->where_id_and_title(20010, 'my title')->get(); # return empty array
$posts = DB::table('posts')->where_id_or_title(20010, 'my title')->get(); # array contains one object
$posts = array_merge($_old_posts, $posts);
```
```php
/* Anonymous functions/Closures */
$posts = DB::table('posts')->where(function($query){
	$query->where('id', '=', 3);
	$query->where('title', '=', 'my title'); # ->or_where()
})->get();
```
```php
/* silly pagination */
$count = 5;
$perpage = 2;
$page = 3;
$pagecount = ceil($count/$perpage);
$posts = DB::table('posts')->where('id', '>', ($page-1)*$perpage)->take(2)->get(); # take() function works as LIMIT statement
/* laravel built-in pagination */
# using page parameter from $_GET['page']
$posts = DB::table('posts')->paginate($perpage); 
# Generate the pagination links:
$posts->links();
```
