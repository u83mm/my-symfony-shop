
<h3 align="center">RUN THE PROJECT</h3>
<li>Clone the repository:</li>    

    git clone "git-repo-name"
    cd /project-name

<li>Create .environ file with DB credentials</li>

    Create .environ file in "MariaDB" directory with your DB credentials:

    MYSQL_ROOT_PASSWORD: root_password
    MYSQL_DATABASE: database_name
    MYSQL_USER: user_name
    MYSQL_PASSWORD: password_user

<li>Build</li>

    mkdir db_vol log log/apache log/db log/php
    docker compose build  
    docker compose up -d
    docker exec -it php bash
    composer install
    exit


<li>Import SQL file "my_database.sql"</li>

    I do it accessing to phpMyAdmin in local host:
        http://localhost:8080/
        user: pepe
        passw: pepe

        Import "my_database.sql" file from MariaDB directory.

<li>Accessing the application</li>

    type "http://localhost/en " in the url in the browser

<li>Login as admin user</li>

    user: admin@admin.com
    passw: adminadmin

### Enjoy!