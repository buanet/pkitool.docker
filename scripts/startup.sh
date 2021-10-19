#!/bin/bash

# Installing PKIT

if [ -f /opt/PKIT/pki.sh ]
then
  echo "PKIT detected."
  echo ' '
else 
  echo "No PKIT detected. Installing..."
  cd /opt/
  git clone https://github.com/KlausWolfinger/PKIT.git
  chmod +x /opt/PKIT/pki.sh
  echo "Done."
  echo ' '
fi

# Set permissions

chown -R pki:pki /opt/PKIT

# Alias for pki.sh

echo "alias pki='/opt/PKIT/pki.sh'" >> /home/pki/.profile

# Start shellinabox

/etc/init.d/shellinabox start

# Keep container alive

tail -f /dev/null
