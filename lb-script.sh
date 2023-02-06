#!/bin/bash

# This script has been authored by Matthew Hooson.
#
# The script is heavily inspired by and based on Google's original work with the
# App Engine shell script:
# https://googletagmanager.com/static/serverjs/setup.sh
#
# Contributions to:
# https://github.com/sahava/sgtm-cloud-run-shell/blob/main/cr-script.sh

IMG_URL="gcr.io/cloud-tagging-10302018/gtm-cloud-image:stable"
WISH_TO_CONTINUE="Do you wish to continue? (y/N): "
WELCOME_TEXT=\
"Please input the following information to set up your load balancer. For more
information about the configuration, input '?'. To use the recommended setting
or your current setting, leave blank."
STATIC_IP_HELP=\
"The static IP is used so that a domain name can be associated with your load balancer "
trap "exit" INT
set -e




prompt_static_ip() {
  while [[ -z "${static_ip}" || "${static_ip}" == '?' ]]; do
    suggested="$(generate_suggested "${cur_static_ip}" "Required")"
    printf "Static IP name (${suggested}): "
    read static_ip
    if [[ -z "${static_ip}" ]]; then
      static_ip="${cur_static_ip}"
    fi

    if [[ "${static_ip}" == '?' ]]; then
      echo "${STATIC_IP_HELP}"
    elif [[ -z "${static_ip}" || "${static_ip}" == 'null' ]]; then
      echo "  Must enter name for static IP."
    fi
  done
}


deploy_production_server() {
  if [[ "${policy_script_url}" == "''" ]]; then
    policy_script_url=""
  fi
  echo "Creating static IP -prod, press any key to begin..."
  project_id=$(gcloud config list --format 'value(core.project)')
  read -n 1 -s
  prod_url=$(gcloud compute addresses create --global ${static_ip})
 
}


echo "${WELCOME_TEXT}"
prompt_static_ip


