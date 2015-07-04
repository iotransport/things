#!/usr/bin/perl -w

# Rudimentary Unique device counter
# Leon Wright <techman@cpan.org> - 2015-07-04
# Makes ALL THE ASSSUMPTIONS!
# Is generally naive.
# Many yaks were shaved.

use strict;
use warnings;
use 5.010;
use autodie;
use List::MoreUtils qw(uniq);
use File::Slurp;
use LWP::UserAgent;
 
my $ua = LWP::UserAgent->new;

# set iotransport ip in hosts
my $server_endpoint = "http://iotransport:1337/snapshot";

while ( 1 == 1 ) {
  my @lines;
  if (-f "/tmp/macs.txt" ) {
    @lines = read_file( '/tmp/macs.txt' );
    unlink('/tmp/macs.txt');
  }

  if (@lines) {

    my @uniq = uniq @lines;

    my $unique = @uniq;


    # set custom HTTP request header fields
    my $req = HTTP::Request->new(POST => $server_endpoint);
    $req->header('content-type' => 'application/json');
     
    # add POST data to HTTP request body
    my $post_data = "{ \"device\":\"space3d\",\"count\":\"$unique\" }";
    $req->content($post_data);
     
    my $resp = $ua->request($req);
    if ( ! $resp->is_success) {
        say "HTTP POST error code: ".$resp->code;
        say "HTTP POST error message: ".$resp->message;
    }

    say "There are $unique unique devices";
  }
  sleep 120;
}

