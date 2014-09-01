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

### Laravel ORM Eloquent
http://three.laravel.com/docs/database/eloquent
```php
$users = User::all(); # return anarray
$users = User::find(1); # return an object
$users = User::find(1)->only('email'); # getting the value of a single column:
```
```php
/* using dynamic methods */
$email = 'deev@deev';
$pass = 'passdeev';

$user = User::where_email_and_password($email, $pass)->first();
echo ($user) ? 'correct' : 'not correct';
```
### inserting method-1
```php
$user = new User();
$user->email = 'laravel@laravel';
$user->password = Hash::make('laravel');
$user->save();
```
### inserting method-2
```php
$user = User::create(array('email' => 'king@king', 'password' => Hash::make('king')));
echo ($user) ? 'Success' : 'fail';
```
### updating and deleting
```php
# updating
$user = User::find(1);
$user->password = Hash::make('deev');
echo $user->save();

# deleting
$user = User::find(10);
echo $user->delete();
```

### Version control with migration
```
# after starting execute the migrate:install command
php artisan migrate:install

# <name> should describe what the migration will do 
php artisan migrate:make <name> 
php artisan migrate:make users_table_creator

php artisan migrate => up()
php artisan migrate:rollback => down()
php artisan migrate:reset
```

# Controllers
### Registring controller
```php
Route::get('/ctrl', 'home@index'); # Home_controller => action_index() method
Route::get('/ctrl/about', 'home@about'); # Home_controller => action_about() method
Route::controller('ctrl');
Route::controller('users');
//or Route::controller(array('ctrl', 'users'));

// automatically detect all the controllers
Route::controller(Controller::detect());
```
### Restful controllers
1. at the top of the controller class define a variable as bellow:
```php
public $restful = true;
```
2. then change methods as bellow
```php
// From
public function action_index(){}

// To
public function get_index(){} /* or, */ public function post_index(){}
```
### Defining REST
```php
# empty
```
### Named routes
```php
// if you want to work restfuly 
           //route                 //route name         //controller@action
Route::get('photos', array('as' => 'photos', 'uses' => 'photos@index'));
Route::get('photos/new', array('as' => 'new_photo', 'uses' => 'photos@new'));
Route::get('photos/(:any)', array('as' => 'show_photo', 'uses' => 'photos@show'));
Route::get('photos/(:any)/edit', array('as' => 'edit_photo', 'uses' => 'photos@edit'));
Route::get('photos/(:any)/delete', array('as' => 'delete_photo', 'uses' => 'photos@delete'));

Route::post('photos', 'photos@index');
Route::put('photos/(:any)', 'photos@update');
Route::delete('photos/(:any)', 'photos@destroy');
```
```php
                      // route name  // text to display
{{ HTML::link_to_route('new_photo', 'Create a new photo') }}
                      // route name  // text to display     // parameters needed by the route
{{ HTML::link_to_action('photos@edit', 'Create a new photo', array('id' => 'asus')) }}
```
### Nested controller
```php
// Controllers may be located within 
// any number of sub-directories within 
// the main application/controllers folder.

// Define the controller class and store it in controllers/admin/panel.php.
class Admin_Panel_Controller extends Base_Controller
{
	public function action_index()
	{
		//
	}
}

// Register the nested controller with the router using "dot" syntax:
Route::controller('admin.panel');

/*
	Note: When using nested controllers, 
	always register your controllers from 
	most nested to least nested in order 
	to avoid shadowing controller routes.
*/
```