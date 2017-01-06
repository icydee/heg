#!/usr/bin/perl
use strict;
use warnings;
 
use Plack::Request;
 
my $app = sub {
    my $env = shift;
 
    my $html = get_html();
 
    my $request = Plack::Request->new($env);
    if ($request->param('email')) {
        return sub {
            my $response = shift;

            $html .= 'Email: '. $request->param('email') . '<br>';
            $html .= 'Feature: '. $request->param('feature') . '<br>';
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

