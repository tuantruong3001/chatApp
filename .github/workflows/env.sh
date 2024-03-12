#!/bin/bash

function replace_values() {
  local file_url=$1
  # replace value

  sed -i "s|\"VUE_APP_API_KEY\": \".*\"|\"VUE_APP_API_KEY\": \"${{ env.APIKEY }}\"|g" "$file_url"

  echo $APIKEY | sed 's/./& /g'

  cat "$file_url"
}

replace_values ./.env
