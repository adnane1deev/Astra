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
