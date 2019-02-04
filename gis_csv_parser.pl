#!/usr/bin/perl
use strict;
use warnings;
use Hunt::Schema;
use Data::Dumper;
use Text::CSV;

#connect db
my $username = $ENV{'PG_USER'};
my $password = $ENV{'PG_PASS'};
my $host     = $ENV{'PG_HOST'};
my $port     = $ENV{'PG_PORT'};
my $db_name  = 'deed';
my $db  = 'dbi:Pg:postgresql://'.$username.':'.$password.'@'.$host.':'.$port .'/'.$db_name;
my $schema = Hunt::Schema->connect($db);
my @results = $schema->resultset('Deed')->search();
map {warn $_->get_columns} @results;

#get it ready
my $csv  = Text::CSV->new({ sep_char => ',' });
my $path_to_gis_csv = "./oakbeachresidents.csv"; 

#open file
open my $fh, '<', $path_to_gis_csv or die "no";

#get header from file
my @header = $csv->header($fh);

while( my $line = $csv->getline($fh) ){
};