# **README**

**FIRST**


To install a new Laravel instance for a project, use the composer container defined in docker-compose:

Change into the project base directory, then.

    find . -name '.DS_Store' -type f -delete

Ensure the target and database directories are empty

    rm -rf ./src/.* ./src/*
    rm -rf ./database/.* ./database/*

use composer to install Laravel into the current directory
  (To install a specific version of Laravel append the version number to the end of the following [i.e.  6.0.\*], or leave it for the current stable version)

    cd ./src
    docker-compose run --rm composer create-project laravel/laravel=^9.0 .

Edit DB setting in ./src/.env (Laravel environment file)

From:  

    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=laravel
    DB_USERNAME=root
    DB_PASSWORD=

To:  

    DB_CONNECTION=mysql
    DB_HOST=mysql
    DB_PORT=3306
    DB_DATABASE=laravel
    DB_USERNAME=root
    DB_PASSWORD='SdkW7BkXsKY6i82UuQ34'


and 

From:

    REDIS_HOST=127.0.0.1
    REDIS_PASSWORD=null
    REDIS_PORT=6379
To:

    REDIS_HOST=redis
    REDIS_PASSWORD=null
    REDIS_PORT=6379

### Now build the rest of the stack

    cd ../
    docker-compose up -d --build



### Now create the database tables using the artisan command as shown below
**Migration Command**  

    docker-compose exec <php service name> php artisan migrate

**Example**  

    cd ./src
    docker-compose exec php php artisan migrate


### Now configure Laravel to work with Mongodb

**Laravel Configurations**

    cd ./src

**MongoDB Extension for Laravel**

    composer require jenssegers/mongodb

    docker-compose run --rm composer require jenssegers/mongodb


**Update .env**

    ....
    ....
    MONGO_CONNECTION=mongodb
    MONGO_HOST=mongo
    MONGO_PORT=27017
    MONGO_AUTH_DATABASE=admin
    MONGO_DATABASE=helloworld
    MONGO_USERNAME=root
    MONGO_PASSWORD= '<password>'
    ....
    ....

Also, update the database configuration by updating config/database.php as shown below.

    ....
    ....
        'default' => env('DB_CONNECTION', 'mysql'),
        //'default' => env('DB_CONNECTION', 'mongodb'),
    ....
    ....
        'connections' => [
    ....
    ....
            'mongodb' => [
                'driver'   => 'mongodb',
                'host'     => env('MONGO_HOST'),
                'port'     => env('MONGO_PORT'),
                'database' => env('MONGO_DATABASE'),
                'username' => env('MONGO_USERNAME'),
                'password' => env('MONGO_PASSWORD'),
                'options'  => [
                    'database' => env('MONGO_AUTH_DATABASE')
                ]
            ],
    ....
    ....


Now, configure the providers to use the MongoDB extension provided by Jens Segers by updating the config/app.php file as shown below.

    ....
    ....
        'providers' => [
    ....
    ....
        Jenssegers\Mongodb\MongodbServiceProvider::class
        ],
    ....
    ....

Now, run the build and up commands to again build the application and launch it. We can access MongoDB using the URL - http://localhost:8081. It will ask for the basic authentication configured by us. The home page should be similar as shown below.
 
Fig. 4
This completes the installation and configuration of MongoDB for the Laravel application.
Summary
