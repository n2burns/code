#!/bin/bash
curl -u burns.nicholas.j@gmail.com --silent "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if //;
print "$2\n" if /<(title|name)>(.*)<\/\1>/;'

