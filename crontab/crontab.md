09 16 * * * logger -t fergus_custom "Deleting `ls /home/ffettes/temp` from temp folder"
10 16 * * * rm -rf /home/ffettes/temp/* 2>&1 | logger -t fergus_custom
