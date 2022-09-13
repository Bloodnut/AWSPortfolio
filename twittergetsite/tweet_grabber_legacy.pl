#!/usr/bin/perl -l

use CGI qw/:standard/;
use LWP::UserAgent;
use JSON;
use URI ();
use Data::Dumper;


print "Content-type: text/html\n\n\ \n\n";

print qq(<!DOCTYPE html>
<head>

<link rel="stylesheet" href="style.css">
<h1> This is my api call page </h1></br>
</head>
<body>
<p>Bellow, you'll be able to see the output from the api</p></br>
<form action="tweet_grabber.pl"></br>
        <input type="submit" value="call API">
</form>
<p>);

print("Let's test the basic API call </br>");

my $apiCallData = makeAPICall();
print $apiCallData;

print qq(
</p>
</body>
</html>
);

sub makeRandomNumber {
    my $randomNumber = int(rand(100000000));
    return $randomNumber;
}

sub makeAPICall {
    #some basic vars to use
    my $twitterId = makeRandomNumber();
    my $baseUrl = "https://api.twitter.com/2/tweets/$twitterId";
    my %params = (
        "expansions" => "author_id"
    );

    # get a UA object
    my $ua = LWP::UserAgent->new(
        ssl_opts => { verify_hostname => 0 },
        protocols_allowed => ['https'],
    );

    # make my modified url using URI
    my $url = URI->new( $baseUrl );
    $url->query_form( %params );  

    # assign a request
    my $request = HTTP::Request->new( 
        "GET",
        "$url",
        HTTP::Headers->new()
    );

    # my headers for the API request
    $request->header('Accept' => 'application/json');
	$request->header('Content-Type' => 'application/json');
    $request->header('Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAAPp1eAEAAAAANbpGzGfMVavvKE5eDpCXzTl180s%3DZNoq1Cq0CxgVQZ5nLaTLWHxxZWGS2uEbgFdA5PxzqQYyITuaYh');

    # pass the request to the obj... see what happens?
    my $response = $ua->request($request);
    my $request_succeeded = 0;

    if ($response->is_success) {
        my $response_value = $response->decoded_content;
        my $json_data = from_json($response_value);
        my $errorMsg = $json_data->{errors}->[0]->{detail};
        
        # handle if tweet is inaccessible 
        if($errorMsg){
            print("<b>It's fairly likely this tweet didn't work or was inaccessible</b> , so here's the detailed message from twitter: $errorMsg </br>");
            print("Hit the button above to try again!");
	}
        else {
            print("<b>Your tweet worked! Hooray!!!</b> </br>");
            my $tweet_id = $json_data->{data}->{id};
            print("<b>The id of the tweet should be:</b> $tweet_id </br>");
            my $tweet_text = $json_data->{data}->{text};
            print("<b>The message of the tweet should be: </b>$tweet_text </br>");
            my $tweet_author = $json_data->{includes}->{users}->[0]->{name};
            print("<b>The author of the tweet should be:</b> $tweet_author </br>");
            my $tweet_authorID = $json_data->{data}->{author_id};
            print("<b>Their ID is:</b> $tweet_authorID </br>");
        }
    }
    else {
        print("The API call didn't work at all :( ");
    }
}
