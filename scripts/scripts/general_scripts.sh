#!/bin/bash

function fix_bluetooth {
  sudo rmmod btusb
  sudo rmmod btintel

  sudo modprobe btintel
  sudo modprobe btusb
  echo "Bluetooth restarted."
}
