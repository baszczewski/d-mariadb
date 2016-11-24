#!/bin/bash
set -e

InstallDatabase()
{
    echo "=> install db"
    mysql_install_db

    # allow access
    chmod -R 777 /db

    # init variables
    USER=${MARIADB_USER:-root}

    # random password if needed
    if [ "$MARIADB_PASS" = "**Random**" ]; then
        unset MARIADB_PASS
    fi
    PASS=${MARIADB_PASS:-$(pwgen -s 12 1)}

    # start database server
    service mysql start

    # now db is available
    echo "=> db is running"
    
    # create main user
    echo "=> creating MySQL user ${USER} with ${PASS} password"
    /usr/bin/mysql -uroot -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS'"
    /usr/bin/mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION"

    # stop database server
    echo "=> stop db"
    
    service mysql stop
}

# if database is not instaled
if [ ! -d /db/mysql ]; then
    InstallDatabase
fi

exec "$@"