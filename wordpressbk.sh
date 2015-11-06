#!/usr/bin/env bash
#+-----------+
#|WordpressBK|
#+-v1.0------+------+
#|Brought to you by:|
#| Shotokan@aitch.me|
#+-PGP-AHEAD--------+----------+
#|https://keybase.io/ShotokanZH|
#+-$BEGIN----------------------+

wp_path="www";
bk_path="backup";
sh_user="shotokan"; #put here the username of the owner of the wordpress install.
#don't edit below!
chown "root:root" "$0";
chmod "700" "$0";
sh_path="$(cat /etc/passwd | grep "^${sh_user}:" | cut -d":" -f 6)";

echo "Path: ${sh_path}";
cd "${sh_path}";


function retrieve_var {
        wp_path=$1;
        var=$2;
        cat "${wp_path}/wp-config.php" | grep -iP "^define\('DB_${var}'" | cut -d"'" -f 4;
}

user="$(retrieve_var ${wp_path} USER)";
pass="$(retrieve_var ${wp_path} PASSWORD)";
dbname="$(retrieve_var ${wp_path} NAME)";

DOW="$(date +%-w)-$(date +%-A)";
TMPF="$(mktemp --suffix ".sql")";

cd "${bk_path}"
chown -R "root:${sh_user}" .
chmod 640 .

echo "Backupping..";
mysqldump --user="${user}" --password="${pass}" "${dbname}" > "${TMPF}"

echo "Compressing '${TMPF}'..";
rm "${DOW}.zip" 2>/dev/null;
zip "${DOW}.zip" "${TMPF}";
du -h "${TMPF}";
du -h "${DOW}.zip";

echo "Removing uncompressed file..";
rm "${TMPF}";

echo "Giving R/O access to '${sh_user}'.."
chown "root:${sh_user}" "${DOW}.zip";
chmod 640 "${DOW}.zip"

echo "Done.";
