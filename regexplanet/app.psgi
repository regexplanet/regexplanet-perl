use strict;
use warnings;
use JSON;
use Perl::Version;

my $app = sub {
	my $env = shift;

	if ($env->{PATH_INFO} eq '/')
	{
		return [ 307, ['Location' => 'http://www.regexplanet.com/advanced/perl/index.html'], [ 'See RegexPlanet.com to test your Perl regular expressions' ] ];
	}
	elsif ($env->{PATH_INFO} eq '/status.json')
	{
		my $data;

		$data = {
			'$OSNAME' => $^O,
			'$PERL_VERSION' => Perl::Version->new($^V)->stringify,
			'psgi.version' => join("x", $env->{'psgi.version'}),
			'psgi.url_scheme' => $env->{'psgi.url_scheme'},
			'psgi.multithread' => $env->{'psgi.multithread'},
			'psgi.multiprocess' => $env->{'psgi.multiprocess'},
			'psgi.nonblocking' => $env->{'psgi.nonblocking'},
			'psgi.streaming' => $env->{'psgi.streaming'},
			'REMOTE_ADDR' => $env->{REMOTE_ADDR},
			'SERVER_NAME' => $env->{SERVER_NAME},
			'SERVER_PORT' => $env->{SERVER_PORT},
			'SERVER_PROTOCOL' => $env->{SERVER_PROTOCOL},
			"success" => JSON::true,
			};

		my $body = to_json($data, {'utf8' => 1, 'pretty'=> 0});

		return [200, ['Content-Length' => length($body), 'Content-Type' => 'text/plain; charset=UTF8'], [$body]];
	}
	elsif ($env->{PATH_INFO} eq '/test.json')
	{
		my $data;

		$data = { "success" => JSON::true, "html" => '<div class="alert alert-warning">Actually, it is a lot less than beta: the real code isn\'t even written yet!</div>' };

		my $body = to_json($data, {'utf8' => 1, 'pretty'=> 1});

		return [200, ['Content-Length' => length($body), 'Content-Type' => 'text/plain; charset=UTF8'], [$body]];
	}
	else
	{
		return [ 404, ['Content-Type' => 'text/html'], [ "404 Not Found: " + $env->{PATH_INFO} ] ];
	}
};

$app;
