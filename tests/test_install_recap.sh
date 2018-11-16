#!/bin/bash

# Switch to the bind mount to install recap
cd /recap

# Install recap
make PREFIX="/usr" BINPATH="/bin" install

# Enable all the plugins available
sed -i 's/^#\(USEPLUGINS\)=.*$/\1="yes"/' /etc/recap.conf
for plugin in $(ls ${PREFIX}/lib/recap/plugins-available/); do
  sudo ln -fs \
    ${PREFIX}/lib/recap/plugins-available/${plugin} \
    ${PREFIX}/lib/recap/plugins-enabled/${plugin}
done

# Clean temporary files
make clean

# Verify recap is available after installation
type -p recap >/dev/null
exit $?
