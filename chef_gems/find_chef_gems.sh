#!/bin/bash
gem search -r 'chef' | grep -v knife- | grep -v bookchef | grep -v REMOTE | awk NF
gem search -r berkshelf | grep -v REMOTE | awk NF
gem search -r ridley | grep -v REMOTE | awk NF
gem search -r foodcritic | grep -v REMOTE | awk NF
gem search -r jvmargs | grep -v REMOTE | awk NF
gem search -r vagrant-berkshelf | grep -v REMOTE | awk NF
gem search -r vagrant-omnibus | grep -v REMOTE | awk NF
gem search -r kitchen | grep -v kitchensink | grep -v gst-kitchen | grep -v chefkitchen_cli | grep -v REMOTE | awk NF
gem search -r strainer | grep -v REMOTE | awk NF
gem search -r busser | grep -v REMOTE | awk NF
gem search -r emeril | grep -v REMOTE | awk NF
gem search -r '^fog$' | grep -v REMOTE | awk NF
gem search -r '^right_aws$' | grep -v REMOTE | awk NF
gem search -r 'spiceweasel' | grep -v REMOTE | awk NF
