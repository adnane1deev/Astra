# Composer introduction
Installation de monolog/monolog library as following :

1. touch composer.json
2. vim composer.json
3. and write the require libraries, in our case which is monolog/mmonolog in any version :

```
{
	"require" :{
		"monolog/monolog" : "*"
	}
}
```

# Learning about library versions
### Semantic Versioning 2.0.0
#### Summary

Given a version number MAJOR.MINOR.PATCH, increment the :

1. MAJOR version when you make Incompatible API changes
2. MINOR version when you add functionality in a backwards-compatible manner
3. PATCH version when you make backwards-compatible bug fixes

Examples :

Greater than or equal a {version}
```
...
"mustache/mustache" : ">= 2.4"
...
```

Between lower {version} and higher {version}
```
...
"mustache/mustache" : ">=2.4, <3.0"
...
```

Any version with specific MAJOR version
```
...
"mustache/mustache" : "2.*"
...
```

The next significant version
```
...
"mustache/mustache" : "~2.4.2" 	-> 2.4.3 ... 2.4.n
or
"mustache/mustache" : "~2.3"	-> 2.4 ... 2.n
...
```

# Install vs. Update
***http://adamcod.es/2013/03/07/composer-install-vs-composer-update.html***

Here's a fairly standard composer work-flow :

1. Add composer.json with some dependencies
2. Run composer install
3. Add some more dependencies
4. Run composer update as you've updated your dependencies

This is the right way to use composer. If you are using composer to deploy your dependencies into a production environment (which many people are), based on this work-flow you may incorrectly assume that you deploy your updated composer.json to production and run composer update again. This is the wrong way to use composer.

What's really happening when you run composer update is that it's fetching the newest version of your dependencies as specified by composer.json.

If you've been testing your code with monolog 1.2, and monolog 1.3 gets released, unless you're very explicit in your composer.json composer will fetch monolog 1.3. Now imagine that a backward incompatible change or bug is introduced with monolog 1.3. Suddenly your dependencies have broken your production environment. Not good.

What you really need to do is deploy your updated composer.lock, and then re-run composer install. You should never run composer update in production. If however you deploy a new composer.lock with new dependencies and/or versions (after having run composer update in dev) and then run composer install composer will update and install new your new dependencies.

# Finding packages

Searching for dependencies (package-name)
```
composer search package-name
composer search package-name -N
```

Interactive command prompt for searching and installing dependencies
```
composer require
composer require package-name
composer require package-name package-version
```

Show informations about spesific dependency by its name
```
composer show package-name
```

# Projects

Setting up a project from command line using composer
Example :
```
composer create-project laravel/laravel
composer create-project laravel/laravel folder-name package-version
```
