# CodeSamples
This is an example of Puppet configuration to make systems administration and deployments simple.

There is not much code in these three files, but what they do is take a bare Ubuntu Linux install with only Puppet added, and sets up a fully functioning web node running NTP, Apache, MySQL and Ruby.

This was tested by deploying two Amazon EC2 instances, installing puppetmaster on one and just the agent on the other. The puppet configuration was completed, and puppet ran successfully.

## Configuration files
Each system (client and server) have their relevant files in the full system path in this repository. Files are:
- puppet-server/etc/puppet/puppet.conf (puppet server configuration)
- puppet-server/etc/puppet/manifests/site.pp (configuration of nodes/clients)
- puppet-client/etc/puppet/puppet.conf (puppet client configuration)

## Initial server setup
Testing was done with AWS Ubuntu 14.04 64-bit instances. I set up two, one to operate as the puppet server, the other to operate as a web node and puppet client.

### Server Configuration
First, I had to download and setup the puppet repository.
```bash
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
```
Then install the puppet packages.
```bash
sudo apt-get install puppetmaster-passenger
```
After this, put in place the puppet.conf for the server from this repository. A certificate is needed for communication with the Puppet clients. Before starting the Puppet server, run the following to create the server certificate.

```bash
sudo puppet master --verbose --no-daemonize
```
Now to put in place the modules for deploying the ruby node.

I decided to use the PuppetForge modules for Apache, MySQL, NTP and Ruby. So I had to install these before I could push the deployment to the Ruby node.

```bash
sudo puppet module install puppetlabs-ntp
sudo puppet module install puppetlabs-apache
sudo puppet module install puppetlabs-mysql
sudo puppet module install puppetlabs-ruby
```
Now the site.pp file from this repository can be put in place, and the server is ready. Start the Puppet service by starting Apache.
```bash
sudo service apache2 start
```

### Client / Ruby Node config
First, I had to download and setup the puppet repository.
```bash
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
```
Then install the puppet packages.
```bash
sudo apt-get install puppet
```
After this, put in place the puppet.conf for the server from this repository. Start the Puppet service.
```bash
sudo service puppet start
```
The last step is signing the certificate on the Puppet server. Run this command until you see your Ruby node listed.
```bash
sudo puppet cert list
```
Once it is listed, sign the node using the node name from the list.
```bash
sudo puppet cert sign --all
```
Your node is ready to be pushed puppet commands for configuration.

## Push configuration
Now it takes one command on your Puppet server to have the Ruby node install Apache, MySQL, NTP and Ruby.
```bash
sudo puppet apply --noop
```
