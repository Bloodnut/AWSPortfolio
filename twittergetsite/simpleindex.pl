#!/usr/bin/perl -w

use CGI qw/:standard/;
use strict;
use warnings;

print "Content-type: text/html\n\n\n\n";

print qq(<!DOCTYPE html>
<head>
<link rel="stylesheet" href="style.css">
<h1> This is my GET site landing page! If you are here, the button below should absolutely attempt
to grab a tweet and some of it's information. If it doesn't, you can try again! </h1></br>
</head>
<body>
<p> I hope this works, there should be a button below:</p>
<form action="tweet_grabber.pl"></br>
        <input type="submit" value="call API">
</form>
</body>
<html>
);
