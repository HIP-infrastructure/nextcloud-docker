# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:

1. Edit `caddy/Caddyfile.template`, add your domain name and save as `caddy/Caddyfile`
2. Create a folder named `secrets` and add the following txt files to it :
	- `nextcloud_admin_password.txt` # put admin password to this file
	- `nextcloud_admin_user.txt` # put admin username to this file
	- `postgres_db.txt` # put postgresql db name to this file
	- `postgres_password.txt` # put postgresql password to this file
	- `postgres_user.txt` # put postgresql username to this file
3. Edit `.env.template`, set the version of Nextcloud FPM you wish to use as well as your domain, then save as `.env`
4. Run `docker-compose up caddy db` and wait for the db to be installed then `^C`
5. Run `docker-compose up -d`, and you should be ready to go!

To use the Nextcloud command-line interface run `./occ.sh`
