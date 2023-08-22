# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:


1. Install docker and docker-compose on your machine.
2. Edit `caddy/Caddyfile.template`, add your domain name and save as `caddy/Caddyfile`
3. Create a folder named `secrets` and add the following txt files to it :
	- `nextcloud_admin_password.txt` # put admin password to this file
	- `nextcloud_admin_user.txt` # put admin username to this file
	- `postgres_db.txt` # put postgresql db name to this file
	- `postgres_password.txt` # put postgresql password to this file
	- `postgres_user.txt` # put postgresql username to this file
4. Edit `.env.template`, set the version of Nextcloud FPM you wish to use as well as your domain, then save as `.env`
5. Run `./fix_crontab.sh`
6. Run `docker-compose up caddy db` and wait for the db to be installed then `^C`
7. Run `docker-compose up -d`, and you should be ready to go!

To use the Nextcloud command-line interface run `./occ.sh`

## Acknowledgement

This research was supported by the EBRAINS research infrastructure, funded from the European Union’s Horizon 2020 Framework Programme for Research and Innovation under the Specific Grant Agreement No. 945539 (Human Brain Project SGA3).
