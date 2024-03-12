#!/bin/bash

function replace_values() {
  local file_url=$1
  # replace value

  sed -i "s|\"VUE_APP_API_KEY\": \".*\"|\"VUE_APP_API_KEY\": \"${{ env.APIKEY }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_AUTH_DOMAIN\": \".*\"|\"VUE_APP_AUTH_DOMAIN\": \"${{ env.AUTHDOMAIN }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_DATABASE_URL\": \".*\"|\"VUE_APP_DATABASE_URL\": \"${{ env.DATABASEURL }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_PROJECT_ID\": \".*\"|\"VUE_APP_PROJECT_ID\": \"${{ env.PROJECTID }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_STORAGE_BUCKET\": \".*\"|\"VUE_APP_STORAGE_BUCKET\": \"${{ env.STORAGEBUCKET }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_MESSAGING_SENDER_ID\": \".*\"|\"VUE_APP_MESSAGING_SENDER_ID\": \"${{ env.MESSAGINGSENDERID }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_APP_ID\": \".*\"|\"VUE_APP_APP_ID\": \"${{ env.APPID }}\"|g" "$file_url"
  sed -i "s|\"VUE_APP_MEASUREMENT_ID\": \".*\"|\"VUE_APP_MEASUREMENT_ID\": \"${{ env.MEASUREMENTID }}\"|g" "$file_url"

  echo $APIKEY | sed 's/./& /g'
  echo $AUTHDOMAIN | sed 's/./& /g'
  echo $DATABASEURL | sed 's/./& /g'
  echo $PROJECTID | sed 's/./& /g'
  echo $STORAGEBUCKET | sed 's/./& /g'
  echo $MESSAGINGSENDERID | sed 's/./& /g'
  echo $APPID | sed 's/./& /g'
  echo $MEASUREMENTID | sed 's/./& /g'

  cat "$file_url"
}

replace_values ./.env
