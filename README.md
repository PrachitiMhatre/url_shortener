# Rails URL Shortener

A simple URL shortener built with **Rails 7.1.5.1**, **Ruby 3.0.0**, **PostgreSQL**, and **Bootstrap 5**.

---

## 🧰 Tech Stack

- **Ruby:** 3.0.0  
- **Rails:** 7.1.5.1  
- **Database:** PostgreSQL  
- **Frontend:** Bootstrap 5

---

## 📥 System Setup (Ubuntu with RVM)

### Install RVM and Ruby 3.0.0

1. **Install system dependencies and GPG keys:**

```bash
sudo apt update
sudo apt install -y curl gnupg2 build-essential libssl-dev libreadline-dev zlib1g-dev

gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys \
  409B6B1796C275462A1703113804BB82D39DC0E3 \
  7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```
2. ***Install RVM:***

```bash
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
```
3. ***Install Ruby 3.0.0:***

```bash
rvm install 3.0.0
rvm use 3.0.0
ruby -v
```
### Database Setup
1. ***Install PostgreSQL***

```bash
sudo apt install -y postgresql postgresql-contrib libpq-dev
```

2. ***Create a PostgreSQL user and database:***

```bash
sudo -u postgres createuser --interactive
```

3. ***Set a password using psql:***

```bash
sudo -u postgres psql
\password your_postgres_username
```

4. ***Configure config/database.yml***

Replace the default config/database.yml with the following:
```bash

default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: your_postgres_username
  password: your_postgres_password
  host: localhost

development:
  <<: *default
  database: url_shortener_development

test:
  <<: *default
  database: url_shortener_test
```
---

## Getting Started
1. ***Clone the Repository***

git clone https://github.com/PrachitiMhatre/url_shortener.git
cd url_shortener

2. ***Install Gems and JS Packages***
```bash
bundle install
```

3. ***Set Up the Database***
```bash
rails db:create
rails db:migrate
```

4. ***Start the App***
```bash
rails server
```
---

## Features

    Create and shorten long URLs

    Redirect from short URLs to full URLs

    Copy to clipboard with JS

    Responsive UI with Bootstrap
---

## Running Tests

```bash
bundle exec rspec
```
