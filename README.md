#puppet-graphite

Puppet manifest to install and configure graphite

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-graphite.png)](http://travis-ci.org/icalvete/puppet-graphite)

##Actions:

Install and configure [graphite](http://graphite.wikidot.com/)

##Requires:

* Should works in all $::operatingsystem
* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* htpasswd::user from https://github.com/icalvete/puppet-htpasswd
* apache2::site, apache2::alias and apache2::auth_basic from https://github.com/icalvete/puppet-apache2

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
