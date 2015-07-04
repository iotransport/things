#!/usr/bin/perl -w

# Rudimentary Broadcast scraper as POC for GovHack 2015
# Leon Wright <techman@cpan.org> - 2015-07-04
# Makes a lot of assumptions and doesn't channel scan

use strict;
use warnings;
use 5.010;
use autodie qw(:all);
use Regexp::Common qw(net);

system("ifconfig wlan0 down");
system("ifconfig wlan0 promisc");
system("iwconfig wlan0 mode Monitor");
system("ifconfig wlan0 up");

open(TSHARK, "tshark  -i wlan0 -n -l subtype probereq |");

while (<TSHARK>) {
  # This is inefficent as hell, but hey it's a POC
  open(my $fh, '>>', '/tmp/macs.txt');
  chomp;
  my $line = $_;
  chomp($line = $_);
  if($line =~ m/($RE{net}{MAC}).+SSID=Broadcast/) {
    say $fh "$1";
  }
  close $fh;
}
return;

