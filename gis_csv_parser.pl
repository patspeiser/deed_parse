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

#get it ready
my $csv  = Text::CSV->new({ sep_char => ',' });
my $in_dir 	= "./unparsed"; 
my $out_dir = "./parsed";

#open directory
opendir my $directory, $in_dir or die 'couldnt open dir '. $in_dir;

while (my $file = readdir($directory)){
	if ($file ne '.' && $file ne '..'){
		#open file
		my $file_to_open = $in_dir . '/' . $file;
		open my $fh, $file_to_open or warn 'couldnt open file ' . $file;

		#get header from file
		my @header = $csv->header($fh);

		#process rest of file
		while( my $line = $csv->getline($fh) ){
			warn $line;
			my $result = $schema->resultset('Deed')->new({
				tax_map_id 		=> $line->[11],
				first_name 		=> $line->[4],
				last_name  		=> $line->[3],
				street     		=> $line->[5],
				street_number 	=> $line->[8],
				city          	=> $line->[9],
				zip           	=> $line->[0]
			});
			#create db record
			$result->insert;
		};
	}
};

#close dir
closedir($directory);
