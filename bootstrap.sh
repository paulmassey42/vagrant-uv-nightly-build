#!/usr/bin/env bash
#################################################################
echo "************* Bootstrapping from nightly builds started **********************"

echo "deb http://packages.unifiedviews.eu/debian-nightly/ wheezy main" > /etc/apt/sources.list.d/unifiedviews.list
apt-get update -y
apt-get install -y ntp xinit xterm iceweasel gnome gnome-terminal gnome-shell
apt-get install -y gawk dos2unix emacs curl gdm3 make autoconf wget
apt-get install -y apache2 libapache2-mod-auth-cas \
	debconf-utils dpkg-dev build-essential quilt gdebi 
dpkg-reconfigure gdm3

echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server-5.5/root_password_again password root" | debconf-set-selections
echo "mysql-server-5.5 mysql-server-5.5/root_password password root" | debconf-set-selections

echo "mysql-server-5.6 mysql-server/root_password_again password root" | debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.6 mysql-server-5.6/root_password_again password root" | debconf-set-selections
echo "mysql-server-5.6 mysql-server-5.6/root_password password root" | debconf-set-selections
    
echo "unifiedviews-webapp-mysql       frontend/mysql_db_password password root"| debconf-set-selections
echo "unifiedviews-webapp-shared	frontend/mysql_dba_user	string	root" | debconf-set-selections
echo "unifiedviews-webapp-shared      frontend/mysql_dba_password password root"| debconf-set-selections
echo "unifiedviews-webapp-mysql       frontend/mysql_db_user string root" | debconf-set-selections
echo "unifiedviews-webapp-mysql       frontend/mysql_db_password password root"| debconf-set-selections
echo "unifiedviews-webapp-mysql       frontend/mysql_db_user string root"| debconf-set-selections
echo "unifiedviews-backend-mysql      backend/mysql_root password root"| debconf-set-selections
echo "unifiedviews-backend-mysql      backend/mysql_db_password password root"| debconf-set-selections
echo "unifiedviews-backend-mysql      backend/mysql_db_user string root"| debconf-set-selections

# Install the base packages.
wget -O - http://packages.unifiedviews.eu/key/unifiedviews2.gpg.key | apt-key add -

apt-get -y install mysql-server
apt-get -y --force-yes install unifiedviews-mysql \
	unifiedviews-backend-shared \
	unifiedviews-backend-mysql \
	unifiedviews-backend \
	unifiedviews-webapp-shared \
	unifiedviews-webapp-mysql \
	unifiedviews-webapp \
	unifiedviews-plugins
apt-get -y --force-yes install
apt-get autoclean

###############################################################
# Change the default homepage-

apt-get -y install firefox
echo "***** Setup homepage for browser"
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /etc/firefox/pref/syspref.js
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /etc/firefox/syspref.js

echo "*********** done with bootstrap of dev machine containing the nightly builds ***********"
#################################################################
