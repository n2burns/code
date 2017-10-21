find . -type f -printf "%T@ %p\n" | sort -nr | cut -d\  -f2-
