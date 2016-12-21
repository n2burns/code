#!/bin/bash
# Set the default boot entry for GRUB, for the next boot only. + reboot
/usr/sbin/grub-reboot "'Windows 10 (loader) (on /dev/sda2)"
/sbin/reboot
