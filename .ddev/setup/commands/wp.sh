#!/usr/bin/env bash

####################
## BEGIN CONFIG
####################

# Define the doc root.
DOC_ROOT="."

####################
## END CONFIG
####################

# Handles copying the wp config + htaccess file to the docroot.
function doConfigFiles {
  if [ -L "${DOC_ROOT}/wp-content/uploads" ]; then
    rm "${DOC_ROOT}/wp-content/uploads"
  fi

  if [ ! -d "${DOC_ROOT}/wp-content/uploads/" ]; then
    mkdir -p "${DOC_ROOT}/wp-content/uploads/"
  fi
}

# Handles downloading WP core
function doInit() {

  source ".ddev/setup/shared/time-logger.sh"

  DOC_ROOT="web"

  # We are in the app root of the project.
  # Download WP
  progressMessage "Downloading WP core..."
  curl -O https://wordpress.org/latest.zip && unzip -q latest.zip

  # Make sure this file exists. If it doesn't, maybe no internet?
  if test -f "./latest.zip"; then
    rm -R -f ./${DOC_ROOT} && mkdir ./${DOC_ROOT} && mv ./wordpress/* ./${DOC_ROOT} && rmdir ./wordpress/ && rm -f ./latest.zip

    # Coping plugins and themes
    cd "${DOC_ROOT}/wp-content"
    progressMessage "Coping default plugins..."
    cp -a ./plugins/. ../../plugins/

    progressMessage "Coping default themes..."
    cp -a ./themes/. ../../themes/

    # Removing plugins and themes directories from wp-content
    rm -R -f ./plugins && rm -R -f ./themes

    # Create symbolic links.
    ln -s ../../plugins plugins
    ln -s ../../themes themes
    mkdir uploads && chmod -R 0777 uploads

    # Go back into the project directory.
    cd ../../
  fi

  progressMessage "Finishing setup..."

  # Handle config files.
  doConfigFiles

  # Output time.
  displayTime "init"

}
