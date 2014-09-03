#!/bin/bash


# Global varibales definition
controller_suffix='s_Controller'
controller_code_alt=''

migration_name=''
migrations_path='application/migrations'
migration_name_file=''
migration_code=''
table_name=''

current_dir=`pwd`
blue='\e[1;32m'
reset='\e[0m'

# Functions definition
controller_code_template()
{
	p_controller_name=$1
	p_resource_view_folder=$2
	
    controller_code_alt=$( cat <<EOF
<?php\n\n
class $p_controller_name extends Base_Controller\n
{\n
\tpublic \$restful = true;
\n\n
\tpublic function get_index()\n
\t{\n
\t\treturn View::make('$p_resource_view_folder.index');\n
\t}\n\n
}
EOF
)

}

migration_code_template()
{
	content=$1
    migration_code=$( cat <<EOF
<?php
\n\n
class $migration_name 
\n{
\n\t	public function up()
\n\t	{
\n\t\t		Schema::create('$table_name', function(\$table)
\n\t\t		{
\n\t\t\t		   \$table->increments('id');
					$content
\n\t\t\t		   \$table->timestamps();
\n\t\t		});
\n\t	}
\n
\n\t	public function down()
\n\t	{
\n\t\t		Schema::drop('$table_name');
\n\t	}
\n}
EOF
)

}

rebuild_migration_name()
{
	migration_name=$1
	pieces=(${migration_name//_/ })
	migration_name=''
	for piece in ${pieces[@]}
	do
		migration_name=$migration_name'_'${piece^}
	done
	
	migration_name=${migration_name:1}
}
		
if [ $1 == 'resource' ]
then
    
	echo 
	# removing the first element from script arguments
    shift 

	# iterate over script arguments
    for var in "$@" 
    do

		# 
        controller_name=${var^}
        controller_name=$controller_name$controller_suffix

        controller='application/controllers/'$var's.php'
        touch $current_dir/$controller
		echo -e 'Created: '$blue$current_dir/$controller$reset
        
		controller_code_template $controller_name $var # calling controller_code_template() function
		controller_code=$controller_code_alt
		
        echo -e $controller_code > $current_dir/$controller
		model='application/models/'$var'.php'
        touch $current_dir/$model
		echo -e 'Created: '$blue$current_dir/$model$reset
        
        name=${var^}
        echo -e '<?php\n\nclass '$name' extends Eloquent\n{\n\n}' > $current_dir/$model

        mkdir $current_dir/application/views/$var
		view='application/views/'$var'/index.blade.php'
        touch $current_dir/$view
		echo -e 'Created: '$blue$current_dir/$view$reset
		
        echo -e "@layout('layouts.master')" > $current_dir/$view

    done
    echo -e '\nGreat, resources are generated (*_*)'
	
elif [ $1 == 'migration' ]
then
    
	echo 
	# removing the first element from script arguments
    shift 
	
	php artisan migrate:make $1
	
	migration_name_file=$1
	rebuild_migration_name $1
	shift
	
	table_name=$1
	shift
	
	# iterate over script arguments
	content=''
    for var in "$@" 
    do
	
		field_type=(${var//:/ })
		field=${field_type[0]}
		type=${field_type[1]}
		content=$content'\n\t\t\t$table->'$type'("'$field'");'

    done
	
	migration_code_template $content
	echo -e $migration_code > $current_dir/$migrations_path/*$migration_name_file'.php'
	path=`find $migrations_path/*$migration_name_file.php`
	echo -e 'Created: '$blue$current_dir/$path$reset

else
	echo -e "\nusage: gen resource <\e[1;34mresource_names**\e[0m>"
	echo -e "usage: gen migration <\e[1;34mmigration-name\e[0m> <\e[1;34mtable-name\e[0m> <\e[1;34mfield_type**\e[0m>"
fi
