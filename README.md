# Database for the restaurant Tifosi with MySQL

__________________________

## Purpose

Create a database for the fictitious italian restaurant "Tifosi" to help them organize their datas.

____________________________

## Prerequisites

To use those scripts, you need to install one of this following programs:
- MySQL Shell / MySQL Workbench 8.0: https://dev.mysql.com/downloads/workbench
- XAMPP: https://sourceforge.net/projects/xampp/files
- VSCode, to open the files and see the code in case you need to copy/paste it in the shell.

Once the installation is done, create at least a root account and use it to login to your local database.

> With MySQL Shell:
> ```
> \connect root@localhost
> ```
> Then enter your password.


> With XAMPP Shell:
> - If you have a password, enter:
>   ```
>   mysql -u root -p
>   ```
>   Then enter your password.
> - If you don't have a password, enter:
>   ```
>   mysql -u root
>   ```

_________________________________

## Go testing!

### MySQL Workbench / phpmyadmin

To test the database, you can just import the .sql files given in this repository to your database with MySQL Workbench or phpmyadmin. 

You have to import them in this order to prevent any errors:
1. 1_create_table.sql
2. 2_import_data.sql
3. 3_display_data.sql

After importing a file, just click on the "Execute" button to execute all the commands. 

### MySQL Shell / XAMPP Shell (MariaDB)

If you're using MySQL Shell or XAMPP Shell(MariaDB), you'll have to copy/paste the code given once you've logged in.

Follow the script order given previously and also the execution of the 1_create_table.sql file. As there are a lot of comments, you can just copy/paste sections with the SQL code to create the database, import the data and display the data in the shell.
  
