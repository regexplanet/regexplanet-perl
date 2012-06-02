#!/usr/bin/env perl
use ExtUtils::MakeMaker;
WriteMakefile(
	PREREQ_PM => {
		'DateTime'       => 0,
		'JSON'			 => '2.53',
		'Plack::Request' => '0.9976',
		'HTML::Entities' => 0,
	},
);
