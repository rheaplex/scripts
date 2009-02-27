#!/usr/bin/perl

# Rob Myers 2009
# Dedicated to the public domain (copyright and moral rights repudiated/waived) 

# Save and set as the script to call for the Rhizome feed in your feed reader

my $xml = `curl --silent http://feeds.feedburner.com/rhizome-fp?format=xml`;

$xml =~ s/<item.*?<dc:creator>John Michael Boling<\/dc:creator>.*?<\/item>//sg;

print $xml;
