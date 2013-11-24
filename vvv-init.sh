# Init script for VVV Auto Bootstrap Demo 3

echo "Commencing VVV Demo 3 Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS vvv_demo_3"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON vvv_demo_3.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Checking out WordPress SVN"
	svn checkout http://svn.automattic.com/wordpress/trunk/ htdocs
	cd htdocs
	wp core config --dbname="vvv_demo_3" --dbuser=wp --dbpass=wp --dbhost="localhost"
	cd ..
	mysql -u root --password=root vvv_demo_3 < initial-data.sql
else
	echo "Updating WordPress SVN"
	svn up htdocs
fi

# The Vagrant site setup script will restart Nginx for us

echo "VVV Demo 3 site now installed";
