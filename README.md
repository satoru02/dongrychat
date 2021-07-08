# Project

filmy.jp

# Install

* Clone the repository

```
git clone git@github.com:satoru02/living-room.git
cd this.project
```

* Check version

```
 ruby  2.7.2
 rails 6.0.3
 vue   3.12.0
```

* Create database.yml file

```
cp config/database.yml.sample config/database.yml
```

* Create and setup the database

```
bundle exec rake db:create
bundle exec rake db:setup
```

* Start the Rails server

```
bin/server
```



