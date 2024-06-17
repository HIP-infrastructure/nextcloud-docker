#!/bin/bash

provider=$(php occ config:app:get sociallogin custom_providers)

echo "provider"
echo "$provider"
echo "---"


json=$(cat <<-EOF
{
    "custom_oidc": [
        {
            "name": "keycloak",
            "title": "Log in",
            "authorizeUrl": "$BASE_EXTERNAL_URL/realms/$REALM_NAME/protocol/openid-connect/auth",
            "tokenUrl": "$BASE_URL/realms/$REALM_NAME/protocol/openid-connect/token",
            "displayNameClaim": "name",
            "userNameClaim": "preferred_username",
            "userInfoUrl": "$BASE_URL/realms/$REALM_NAME/protocol/openid-connect/userinfo",
            "logoutUrl": "$BASE_URL/realms/$REALM_NAME/protocol/openid-connect/logout?redirect_uri=https%3A%2F%2Fdemo.horus-analytics.chuv.ch",
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
# if [ -n "$provider" ]; then 
#     php occ config:app:set sociallogin custom_providers --value="$json"
# fi