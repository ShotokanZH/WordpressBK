# WordpressBK
Automatic wordpress backupper

# How to make it work
- Edit wp\_path,bk\_path,sh\_user variables according to your system.
  - Example:
    - wp_path="www";
    - bk_path="backup";
    - sh_user="shotokan";
  - Meaning:
    - The user is the shell user "shotokan" (as found in /etc/passwd)
    - The wp\_path variable is the variable telling WHERE the worpdress install is located. Accepts relative & absolute paths. If relative, starts from the home of sh\_user, so in this case, having home="/home/shotokan/" and wp_path="www" the absolute path will be /home/shotokan/www/
    - bk\_path follows the same rules as wp\_path, and it's the location of the backup directory.
- `chmod +x wordpressbk.sh`
- Run it (as root) via `./wordpressbk.sh` or have it added to crontab (once per day)

- Protip: you can set the variables like so, so you can script the backup of many wordpress installs via ARG
  - wp\_path="$1";
  - bk\_path="$2";
  - sh\_user="$3";
- Example: `./wordpressbk.sh www backup shotokan`

Note:

Every backup is compressed in a zip named after the current day (if monday: "1-Monday.zip") and the script will automatically replace the files every week.
