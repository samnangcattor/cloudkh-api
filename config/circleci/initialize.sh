sudo apt-get update -y
sudo apt-cache showpkg mecab
sudo apt-cache showpkg libmecab-dev
sudo apt-get install mecab=0.996-1.1 -y
sudo apt-get install mecab-ipadic-utf8 -y
sudo apt-get install libmecab-dev=0.996-1.1 -y
sudo pip install awscli
sudo cp config/circleci/my.cnf /etc/mysql/my.cnf
sudo service mysql restart
sudo chmod 777 /var/run/mysqld/mysqld.sock
gem uninstall -x bundler
gem install bundler -v 1.13.6
