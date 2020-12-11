# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:

1. Edit `caddy/Caddyfile` and add your domain name
2. Edit `nextcloud/config/config.php` and add your domain name to the list of trusted domains
3. Create a folder name `secrets` and add the following txt files to it :
	- nextcloud_admin_password.txt # put admin password to this file
	- nextcloud_admin_user.txt # put admin username to this file
	- postgres_db.txt # put postgresql db name to this file
	- postgres_password.txt # put postgresql password to this file
	- postgres_user.txt # put postgresql username to this file
4. Run `docker-compose up`
