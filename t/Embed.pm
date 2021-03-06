package t::Embed;
use strict;
use warnings;
use Test::More;
use utf8;
use File::Slurp qw/read_file/;
use FindBin;

no warnings qw/redefine once/;
*LWP::UserAgent::get = sub {
    my ($self, $url) = @_;
    diag $url;
    (my $file = $url) =~ s{[:/.\?&]+}{_}g;
    $file = "$FindBin::Bin/stub/$file";
    diag $file;
    my $content = read_file($file) or die("no stub fo $url");

    #warn $content;

    my $res = HTTP::Response->new(200);
    $res->content_type('text/html/json'); # XXX
    $res->content($content || '');
    return $res;
};

1;
