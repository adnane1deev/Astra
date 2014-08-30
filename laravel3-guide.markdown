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