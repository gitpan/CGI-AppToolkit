#!/usr/bin/perl

foreach (@ARGV) {
	$file = $_;
	$html = $file;
	$html =~ s/(.pm|.pod)$/.html/;
	
	$depth = join '/', (('..') x (scalar(split '/', $file) - 2));
	$root = join '/', (('..') x (scalar(split '/', $file) - 1));

	print "pod2html --infile=$file --outfile=../../Docs/Site/docs/$html --podroot=./ --htmlroot=${depth} --css=${root}/style.css\n";
	
	print `pod2html --infile=$file --outfile=../../Docs/Site/docs/$html --podroot=./ --htmlroot=${depth} --css=${root}/style.css`;
	
	
	open FILE, "../../Docs/Site/docs/$html";
	
	$file = join '', <FILE>;
	
	close FILE;

	
	$file =~ s/(<a name="[^"]+">)(.*?)<\/a>/\1<\/a>\2/ig;
	$file =~ s{<P>Please visit <A HREF="http://www.heavyhosting.net/AppToolkit/">http://www.heavyhosting.net/AppToolkit/</A> for complete documentation.</P>}//ig;

	open FILE, ">../../Docs/Site/docs/$html";
	
	print FILE $file;
	
	close FILE;
	
}