# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:

1. Edit `caddy/Caddyfile` and add your domain name
2. Create a folder named `secrets` and add the following txt files to it :
	- `nextcloud_admin_password.txt` # put admin password to this file
	- `nextcloud_admin_user.txt` # put admin username to this file
	- `postgres_db.txt` # put postgresql db name to this file
	- `postgres_password.txt` # put postgresql password to this file
	- `postgres_user.txt` # put postgresql username to this file
3. Run `docker-compose up caddy db` and wait for the db to be installed then `^C`
4. Run `docker-compose up`, if you check your domain you will see a page asking you to add your domain to the list of trusted domains, then `^C`
5. Edit `nextcloud/config/config.php` and add your domain name to the list of trusted domains by adding the line `1 => 'nextcloud.hbp.link',`
6. Run `docker-compose up -d`, and you should be ready to go!

To use the Nextcloud command-line interface:
`docker-compose exec --user www-data app php occ`
