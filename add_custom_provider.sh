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
            "authorizeUrl": "$BASE_URL/realms/$REALM_NAME/protocol/openid-connect/auth",
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
                "$GROUP_NAME": "$GROUP_NC_NAME"
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
# if [ -n "$provider" ]; then 
#     php occ config:app:set sociallogin custom_providers --value="$json"
# fi