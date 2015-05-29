# CodeSamples
This is an example of Puppet configuration to make systems administration and deployments simple.

There is not much code in these three files, but what they do is take a bare Ubuntu Linux install with only Puppet added, and sets up a fully functioning web node running NTP, Apache, MySQL and Ruby.

This was tested by deploying two Amazon EC2 instances, installing puppetmaster on one and just the agent on the other. The puppet configuration was completed, and puppet ran successfully.
