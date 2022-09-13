#!/usr/bin/perl -w

use CGI qw/:standard/;
use strict;
use warnings;


print "Content-type: text/html\n\n \n\n";

print qq(<!DOCTYPE html>
<head>
<link rel="stylesheet" href="style.css">
<h1> This is my pull site's landing page!! Right now, we should 
be seeing a little form and a 'submit' that will post a 
tweet </h1></br>
</head>
<body>
<p> Here is where I want you to enter in 
your message that needs to be tweeted</p>
<form method='GET' action="tweetposter.pl">
        <label for="tweet-text">What do you want to tweet?</label><br>
        <input type="text" id="tweet-text" name="text">
        <input type="submit" value="call API">
</form>
</body>
<html>
);
