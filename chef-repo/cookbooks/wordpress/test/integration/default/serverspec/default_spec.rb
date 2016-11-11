require 'spec_helper'

describe ("Test packges") do
  describe package("nginx") do
    it { should be_installed }
  end
  describe package("httpd-tools") do
    it { should be_installed }
  end
  describe package("php") do
    it { should be_installed }
  end
  describe package("php-mbstring") do
    it { should be_installed }
  end
  describe package("php-fpm") do
    it { should be_installed }
  end
  describe package("php-mysql") do
    it { should be_installed }
  end
end

describe ("Test nginx") do
  describe service("nginx") do
    it { should be_enabled }
    it { should be_running }
  end
  describe file("/etc/nginx/conf.d/default.conf") do
    it { should exist }
  end
end

describe ("Test php-fpm") do
  describe service("php-fpm") do
    it { should be_enabled }
    it { should be_running }
  end
  describe file("/etc/php-fpm.d/www.conf") do
    it { should exist }
  end
end

describe ("Test wordpress") do
  describe file("/var/www/wordpress/index.php") do
    it { should exist }
  end
  describe file("/var/www/wordpress/wp-config.php") do
    it { should exist }
  end
end
