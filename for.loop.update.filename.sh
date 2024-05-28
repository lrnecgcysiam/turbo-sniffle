for file in /Users/auroraixion/unix.shell.scripts/line.sticker; do
#   echo "${file##*/}"
    wget -O ${file##*/}.png  ${file##*/}
done