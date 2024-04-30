# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:

1. Clone this repository
2. Install docker and docker compose on your machine.
3. Get the latest inotify scan there https://github.com/HIP-infrastructure/nextcloud-inotifyscan/blob/hip/nextcloud-inotifyscan and add it to `nextcloud/nextcloud-inotifyscan`
4. In the folder named `secrets` change the following txt files according to you needs :
	- `postgres_db.txt` 			# put postgresql db name to this file
	- `postgres_password.txt` # put postgresql password to this file
	- `postgres_user.txt` 		# put postgresql username to this file
5. Edit `.env.template`, set the version of Nextcloud FPM you wish to use as well as your domain, then save as `.env`
6. Run `./fix_crontab.sh`
7. Run `docker compose up -d` Nextcloud will fail. Don't bother
```
	docker compose --env-file ./.env -f docker-compose.yml stop
	sudo mkdir -p /var/www
	sudo mkdir -p /mnt/nextcloud-dp/nextcloud
	sudo ln -sf /mnt/nextcloud-dp/nextcloud /var/www/html
	sudo chown -R www-data:www-data /var/www/html
	docker compose --env-file ./.env -f docker-compose.yml build cron
	sudo chown root:root nextcloud
	docker compose --env-file ./.env -f docker-compose.yml up -d
```

Once Nextcloud is installed, we need to replace the created php-settings by our own in order to parametrize it for docker etc.

```
docker compose --env-file ./.env -f docker-compose.yml stop
sudo rm -rf /mnt/nextcloud-dp/php-settings
sudo cp -r php-settings /mnt/nextcloud-dp
docker compose --env-file ./.env -f docker-compose.yml up -d
````

Then perform this command to install Nextcloud, replace the variables by yours. 
Enter your postgress password manually, then your Nextcloud password manually as well.

  - `docker compose exec --user www-data app php occ maintenance:install --database "pgsql"  --database-name "nextcloud"  --database-user "admin" --database-port "5432" --database-host "db" --admin-user "admin"`

- Next, add some params to the Nextcloud php config in  `/mnt/nextcloud-dp/nextcloud/config/config.php`
```
    'htaccess.RewriteBase' => '/',    
    'htaccess.IgnoreFrontController' => true,     
    'defaultapp' => 'hip',
    'trusted_domains' => ['localhost']
```

- Open your browser to your ip or hostname, eg http://localhost
- Access NextCloud with admin
- NextCloud could complain about Access through untrusted domain, and in that case, re-add your domain to the `/mnt/nextcloud-dp/nextcloud/config/config.php` file again. This should fix it.