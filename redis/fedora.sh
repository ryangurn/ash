wget http://download.redis.io/redis-stable.tar.gz
tar -xzf redis-stable.tar.gz
cd redis-stable/
yum install tcl gcc jemalloc -y
make distclean
make install
make test

echo "This shit needs java...U WOOT MATE??!?"
