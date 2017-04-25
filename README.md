# JuvOffendersDashboard
# Licença
Esse aplicativo está licensiado com GNU General Public License v3.0

O aplicativo SocioBoard foi desenvolvido pelo Gabinete da Vice-Governadora do Estado do Ceará.

## Gestão Superior

* Vice-Governadora - Maria Izolda Cela de Arruda Coelho
* Secretário Chefe - Fernando Antônio Costa de Oliveira

## Pessoas que parciparam no projeto

* Gestor de TI - Catulo Hansen
* Analista Desenvolvedor - Leoncio Caminha
* Analista Desenvolvedor - Schwarzenegger Alves
* Analista de Negócio - Hirley Esmeraldo
* Analista Desenvolvedor - Henrique Almeida
* Analista de Negócio -Israel Freitas
* Desenvolvedor - Wesley Ribeiro
* Analista de Infraestrutura - Samuel Lucas
* Analista de Infraestrutura  - Isaque Freitas

# App

This app uses Rails 5.0.0.RC1 and Ruby 2.3.1

## Installing
Before installing, dont forget to install postgres

```console
sudo apt-get install postgresql postgresql-contrib libpq-dev
```

And to have newer version of node then install bower

npm install -g bower

Now to installation


```console
git clone git@github.com:CTIGI/cp_management.git
cp config/database.yml.example config/database.yml
cp config/application.yml.example config/application.yml
bundle install
bundle exec rake db:setup
rake db:test:prepare
rake bower:install
```

## ERRORS

An error occurred while installing [capybara-webkit](https://github.com/thoughtbot/capybara-webkit/issues/707) (1.7.1), and Bundler cannot continue.
Make sure that `gem install capybara-webkit -v '1.7.1'` succeeds before bundling.

resolved:

```
sudo apt-get update && sudo apt-get install libqt5webkit5-dev qtdeclarative5-dev
```

## PhantomJS

[Install PhantomJS](http://phantomjs.org/build.html)

```
sudo apt-get install phantomjs
```

## Before commiting your code

### Use pre-commit gem

Please read https://github.com/jish/pre-commit

```console
  gem install pre-commit
```

My default pre-commit is:

```console
  git config pre-commit.checks "whitespace, pry, yaml, json, before_all, merge_conflict, ruby_symbol_hashrockets, tabs, white_space"
```

# Testing

This app uses Rspec and [Factory Girl](https://github.com/thoughtbot/factory_girl).

Please read [betterspecs.org](http://betterspecs.org/).

Running with [Guard](https://github.com/guard/guard-rspec):

```console
bundle exec guard
```

__Tip:__ You can [use](http://robots.thoughtbot.com/post/40193452558/improving-rails-boot-time-with-zeus) [Zeus](https://github.com/burke/zeus/) to make you tests run faster.
