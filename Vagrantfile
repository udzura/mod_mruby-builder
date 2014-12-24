# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 8880

  config.vm.provision "shell", inline: <<-SHELL
  set -x
  set -e

  [ -f /vagrant/.install-ok ] && exit

  # apt-get -y update
  apt-get -y install git curl apache2
  apt-get -y install libhiredis0.10
  apt-get -y install libmarkdown2

  cp /vagrant/out/mod_mruby.so /usr/lib/apache2/modules

  mkdir -p /etc/apache2/hook
  curl -s -L https://raw.githubusercontent.com/matsumoto-r/mod_mruby/master/docker/hook/test.rb \
      > /etc/apache2/hook/test.rb
  curl -s -L https://gist.githubusercontent.com/udzura/dccf796cc7bfae7c766e/raw/b6b08859be9222782a4cc07b657ceb5991a23c61/md2html.rb \
      > /etc/apache2/hook/md2html.rb
  curl -s -L https://raw.githubusercontent.com/matsumoto-r/mod_mruby/master/docker/conf/mruby.conf \
      > /etc/apache2/mods-available/mruby.conf

  sed -i.bak '/\\/IfModule/d'                                    /etc/apache2/mods-available/mruby.conf
  echo '<Location /mruby-md>'                                  >> /etc/apache2/mods-available/mruby.conf
  echo 'mrubyHandlerMiddle /etc/apache2/hook/md2html.rb cache' >> /etc/apache2/mods-available/mruby.conf
  echo '</Location>'                                           >> /etc/apache2/mods-available/mruby.conf
  echo '</IfModule>'                                           >> /etc/apache2/mods-available/mruby.conf

  echo LoadModule mruby_module /usr/lib/apache2/modules/mod_mruby.so \
      > /etc/apache2/mods-available/mruby.load

  cd /etc/apache2/mods-enabled && \
      ln -sf ../mods-available/mruby.load mruby.load && \
      ln -sf ../mods-available/mruby.conf mruby.conf && \
      cd -

  service apache2 restart
  echo "Lets run curl http://localhost:8880/mruby-test && curl http://localhost:8880/mruby-hello"

  touch /vagrant/.install-ok

  SHELL
end
