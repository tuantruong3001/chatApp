#!/bin/bash

function replace_values() {
  local file_url=$1
  # replace value

  sed -i "s|.*VUE_APP_API_KEY=.*|VUE_APP_API_KEY=$APIKEY,|g" "$file_url"
  sed -i "s|.*VUE_APP_AUTH_DOMAIN=.*|VUE_APP_AUTH_DOMAIN=$AUTHDOMAIN,|g" "$file_url"
  sed -i "s|.*VUE_APP_DATABASE_URL=.*|VUE_APP_DATABASE_URL=$DATABASEURL,|g" "$file_url"
  sed -i "s|.*VUE_APP_PROJECT_ID=.*|VUE_APP_PROJECT_ID=$PROJECTID,|g" "$file_url"
  sed -i "s|.*VUE_APP_STORAGE_BUCKET=.*|VUE_APP_STORAGE_BUCKET=$STORAGEBUCKET,|g" "$file_url"
  sed -i "s|.*VUE_APP_MESSAGING_SENDER_ID=.*|VUE_APP_MESSAGING_SENDER_ID=$MESSAGINGSENDERID,|g" "$file_url"
  sed -i "s|.*VUE_APP_APP_ID=.*|VUE_APP_APP_ID=$APPID,|g" "$file_url"
  sed -i "s|.*VUE_APP_MEASUREMENT_ID=.*|VUE_APP_MEASUREMENT_ID=$MEASUREMENTID,|g" "$file_url"

  cat "$file_url"
}

replace_values ./.env
