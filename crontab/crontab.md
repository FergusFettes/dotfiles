09 16 * * * logger -t fergus_custom "Deleting `ls /home/ffettes/temp` from temp folder"
10 16 * * * rm -rf /home/ffettes/temp/* |& logger -t fergus_custom
19 16 * * * logger -t fergus_custom "Daily backup of dotfiles."
20 16 * * * cd /home/ffettes/dotfiles && git commit -am "scheduled backup of dotfiles" |& logger -t fergus_custom && git push
