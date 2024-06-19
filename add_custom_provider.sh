#!/bin/bash

provider=$(php occ config:app:get sociallogin custom_providers)

echo "provider"
echo "$provider"
echo "---"

redirect_uri_encoded=$(echo -n "$BASE_URL" | php -r 'echo rawurlencode(fgets(STDIN));')


json=$(cat <<-EOF
{
    "custom_oidc": [
        {
            "name": "keycloak",
            "title": "Log in",
            "authorizeUrl": "$IAM_BASE_EXTERNAL_URL/realms/$REALM_NAME/protocol/openid-connect/auth",
            "tokenUrl": "$IAM_BASE_URL/realms/$REALM_NAME/protocol/openid-connect/token",
            "displayNameClaim": "name",
            "userNameClaim": "preferred_username",
            "userInfoUrl": "$IAM_BASE_URL/realms/$REALM_NAME/protocol/openid-connect/userinfo",
            "logoutUrl": "$IAM_BASE_EXTERNAL_URL/realms/$REALM_NAME/protocol/openid-connect/logout?redirect_uri=$redirect_uri_encoded",
            "clientId": "$CLIENT_ID",
            "clientSecret": "$CLIENT_SECRET",
            "scope": "openid group profile email roles team",
            "groupsClaim": "roles.group",
            "style": "",
            "defaultGroup": "",
            "groupMapping": {
                "$GROUP_NAME": "$GROUP_NC_NAME",
                "epfl-esl": "epfl-esl",
                "uka": "uka",
                "vr-vis": "vr-vis",
                "ucl": "ucl",
                "chuc": "chuc",
                "amu-ns": "amu-ns",
                "chuv": "chuv",
                "amu-tng": "amu-tng",
                "aphm": "aphm",
                "chru-lille": "chru-lille",
                "chm": "chm",
                "chuga": "chuga",
                "chu-lyon": "chu-lyon",
                "fnusa": "fnusa",
                "hus": "hus",
                "chru-s": "chru-s",
                "ou-sse": "ou-sse",
                "psmar": "psmar",
                "ucbl": "ucbl",
                "umcu": "umcu"
            }
        }
    ]
}
EOF
)

echo "json"
echo "$json"
echo "---"

php occ config:app:set sociallogin custom_providers --value="$json"
php occ config:app:set sociallogin update_profile_on_login --value=1
php occ config:app:set sociallogin hide_default_login --value=1
php occ config:app:set sociallogin button_text_wo_prefix --value=1
php occ config:system:set trusted_domains 1 --value="$NEXTCLOUD_TRUSTED_DOMAINS"
php occ theming:config color "$BACKGROUND_COLOR"
if [ -e "/var/www/html/shared/logo.png" ]; then
    php occ theming:config logo "/var/www/html/shared/logo.png"
fi
# if [ -n "$provider" ]; then 
#     php occ config:app:set sociallogin custom_providers --value="$json"
# fi