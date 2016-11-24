#!/bin/bash

ConfigureMySQL()
{
    # set configuration file
    rm /etc/mysql/my.cnf
    cp /tmp/my.cnf /etc/mysql/my.cnf

    # remove old database
    rm -Rf /var/lib/mysql
}

ConfigureMySQL