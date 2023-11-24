# nextcloud-docker

To install Nextcloud on a new machine, follow these steps:

1. Install docker and docker-compose on your machine.
2. Edit `caddy/Caddyfile.template`, add your domain name and save as `caddy/Caddyfile`
3. Get the latest inotify scan there https://github.com/HIP-infrastructure/nextcloud-inotifyscan/blob/hip/nextcloud-inotifyscan and add it to `nextcloud/nextcloud-inotifyscan`
4. Create a folder named `secrets` and add the following txt files to it :
	- `nextcloud_admin_password.txt` # put admin password to this file
	- `nextcloud_admin_user.txt` # put admin username to this file
	- `postgres_db.txt` # put postgresql db name to this file
	- `postgres_password.txt` # put postgresql password to this file
	- `postgres_user.txt` # put postgresql username to this file
5. Edit `.env.template`, set the version of Nextcloud FPM you wish to use as well as your domain, then save as `.env`
6. Run `./fix_crontab.sh`
7. Run `docker-compose up caddy db` and wait for the db to be installed then `^C`
8. Run `docker-compose up -d`, and you should be ready to go!

To use the Nextcloud command-line interface run `./occ.sh`

- `make install-nextcloud` Nextcloud will 
- fail. Don't bother
- Once Nextcloud is installed, we need to replace the created php-settings by our own in order to parametrize it for docker etc.
  - `sudo rm -rf /mnt/nextcloud-dp/php-settings`
  - `sudo cp -r php-settings /mnt/nextcloud-dp`

- `make install-nextcloud` It will fail, again. 
  - `make occ c=maintenance:install`
  - Nextcloud install asks fo a password for admin, use the one provided in secrets in [nextcloud_admin_password.txt]

- Add some params to the Nextcloud php config in  `/mnt/nextcloud-dp/nextcloud/config/config.php`
```
    'htaccess.RewriteBase' => '/',    
    'htaccess.IgnoreFrontController' => true,     
    'defaultapp' => 'hip',
    'trusted_domains' => ['hip.local'],
```
- `make install`
- Open your browser to your ip or hostname
- Access NextCloud with admin/[nextcloud_admin_password.txt]
- NextCloud could complain about Access through untrusted domain, and in that case, re-add your domain to the `/mnt/nextcloud-dp/nextcloud/config/config.php` file again. This yhould fix it.
- sudo pm2 restart all to restart ghostfs

#### Social-login app, OIDC client, groups
Social login is a Nextcloud app, customized for our need, helping the OIDC login process for users.

- With the current Keycloak setup, you need an EBRAINS account. 
  - Either on production https://iam.ebrains.eu/register or development, https://[iam-provider-url]/register
- Center will be mapped to EBRAINS keycloak groups, we will need to add you there manually on EBRAINS for authorization purposes.
- Create a group for your Center via the NC api.
  - `make occ c="group:add  --display-name CHUV chuv"`

- Open settings under you profile, on the top right.
- Choose "Social Login" under the administration menu, in the left sidebar  
  - [x] Update user profile every login
  - [x] Hide default login
  - [x] Button text without prefix


- Add a Custom OpenID Connect client.

| Key | Value |
| --- | --- |
| Internal name | dev.thehip.app |
| Title | EBRAINS-INT |
| Authorize url | https://[iam-provider-url]/auth/realms/hbp/protocol/openid-connect/auth |
| Token url | https://[iam-provider-url]/auth/realms/hbp/protocol/openid-connect/token |
| Display name claim (optional) | name |
| Username claim (optional) | preferred_username |
| User info URL (optional) | https://[iam-provider-url]/auth/realms/hbp/protocol/openid-connect/userinfo | 
| Client Id | [iam-client_id] | 
| Client Secret | [iam-client_secret] |
| Scope | openid group profile email roles team | 
| Groups claim (optional) | roles.group |

Add group mapping 

| Key | Value |
| --- | --- |
| group-HIP-dev-CHUV | chuv | 

Save everything, logout, and try to login with your EBBRAINS credentials

if you want to migrate an existing install to a new location, here are a few tips [Nextcloud-migration.md](https://github.com/HIP-infrastructure/frontend/blob/master/Nextcloud-Migration.md)