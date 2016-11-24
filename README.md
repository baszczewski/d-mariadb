baszczewski-mariadb
==================

Usage
-----

To create the image `baszczewski/mariadb`, execute the following command on the folder:

	docker build -t baszczewski/mariadb .

Running
------------------------------

**developer option**

* expose port to host (insecure);
* store database on host directory;

docker run -d --name mariadb -p 3306:3306 -e 'MARIADB_USER=user' -e 'MARIADB_PASS=password' -v /home/user/mariadb:/db:Z baszczewski/mariadb

**the preferred option**

* use link to access database;

docker run -d --name mariadb -e 'MARIADB_USER=user' -e 'MARIADB_PASS=password' baszczewski/mariadb