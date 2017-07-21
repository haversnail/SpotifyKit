#!/bin/sh

#  ModuleMaps.sh
#  SpotifyKit
#
#  Created by Alexander Havermale on 7/20/17.
#  Copyright © 2017 Alex Havermale. All rights reserved.

# Define Modules:
dmod() {
    # Check if the SDK has been checked out by Carthage:
    SDK_DIR="Carthage/Checkouts/ios-sdk"
    if [ -d $SDK_DIR ]; then
        # For each framework argument provided,
        for FRAMEWORK in $@; do
            # Make sure we actually have that framework; if so,
            FRAMEWORK_PKG="${SDK_DIR}/${FRAMEWORK}.framework"
            if [ -d $FRAMEWORK_PKG ]; then
                # Then create the module map directory, if one doesn't already exist:
                MODULES_DIR="${FRAMEWORK_PKG}/Modules"
                mkdir -p $MODULES_DIR
                # And lastly, if there isn't already a modulemap file, then create one and write what we need to it:
                MODULEMAP_FILE="${MODULES_DIR}/module.modulemap"
                if [ ! -e $MODULEMAP_FILE ]; then
                    touch $MODULEMAP_FILE
                    echo "framework module ${FRAMEWORK} {\n\tumbrella header \"${FRAMEWORK}.h\"\n\n\texport *\n\tmodule * { export * }\n}" > $MODULEMAP_FILE
                fi
            fi
        done
    fi
}

dmod SpotifyAudioPlayback SpotifyAuthentication
