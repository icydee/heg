#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Plack::Request;
use HEG::DB;

my $db_file = "$FindBin::Bin/../etc/db.sql";

my $db = HEG::DB->connect("dbi:SQLite:$db_file");
$db->deploy({ add_drop_table => 1 });

my $app = sub {
    my $env = shift;
 
    my $html = get_html();
 
    my $request = Plack::Request->new($env);
    my $email = $request->param('email');
    my $feature = $request->param('feature');

    if (defined $email) {
        return sub {
            my $response = shift;

            $html .= "Email: $email<br/>";
            $html .= "Feature: $feature<br/>";

            # save to database
            $db->resultset('Feature')->create({
                email => $email,
                feature => $feature,
            });
                return $response->([
                    '200',
                    [ 'Content-Type' => 'text/html' ],
                    [ $html ],
                ]);
            
        };
    }
 
    return [
        '200',
        [ 'Content-Type' => 'text/html' ],
        [ $html ],
    ];
}; 
 
sub get_html {
    return q{
      <form>
 
      <input name="email">
      <input name="feature">
      <input type="submit" value="Submit">
      </form>
      <hr>
    }
}

