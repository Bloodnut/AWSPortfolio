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
<p>Below, you'll be able to see the output from the api</p></br>
<p>);

print("Let's test the API call </br>");

my $apiCallData = makeAPICall();
print $apiCallData;

print qq(
</p>
</body>
</html>
);

sub makeAPICall {
    #some basic vars to use
    my $baseUrl = "https://api.twitter.com/2/tweets";

    #taken form previous form
    my $bodyText = capture_input();
    my %jsonArr = ('text' => $bodyText);
    my $bodyTextJSON = encode_json \%jsonArr;
  
    print $bodyTextJSON;
    # get a UA object
    my $ua = LWP::UserAgent->new(
        ssl_opts => { verify_hostname => 0 },
        protocols_allowed => ['https'],
    );

    # assign a request
    my $request = HTTP::Request->new( 
        "POST",
        "$baseUrl",
        HTTP::Headers->new()
    );

    # my headers for the API request
    $request->header('Accept' => 'application/json');
	$request->header('Content-Type' => 'application/json');
    $request->header('Authorization' => 
    'OAuth oauth_consumer_key="UvLInXy98PTQg35Ieur99A5SU",
    oauth_token="878484823-8xdfwYTTuixVQRDa4XW1IeNupU5aCl66m0qIBHUk",
    oauth_signature_method="HMAC-SHA1",oauth_timestamp="1657981191",
    oauth_nonce="o2ASpvecCA8",oauth_version="1.0",
    oauth_signature="wxGjYDdvF6kJVUi3dnW69IC%2BM8Q%3D"');
    $request->content( $bodyTextJSON );

    # pass the request to the obj... see what happens?
    my $response = $ua->request($request);
    my $request_succeeded = 0;

    my $response_value = $response->decoded_content;
    my $json_data = from_json($response_value);
    my $errorMsg = $json_data->{errors}->[0]->{message};
    
    # handle if tweet is inaccessible 
    if($errorMsg){
        print("We hit an auth error for sure $errorMsg </br>");
    }
    # handle if tweet flat out fails
    elsif($failMsg=401){
        print("Dang, the tweet didn't work at all and pulled a 401! Go back to index.pl to try again
        </br>");
    }	
    else {
	print("The response I got is: $response_value </br>");	
        print("Your tweet worked! Hooray!!! </br>");
        my $tweet_id = $json_data->{data}->{id};
        print("the id of the tweet should be: $tweet_id </br>");
        my $tweet_text = $json_data->{data}->{text};
        print("the message of the tweet should be: $tweet_text </br>");
        print("you can view the tweets to check here: https://twitter.com/OptimusLimes93 </br>")
    }
}

sub capture_input {
    my $q = new CGI;
    my $inputText = $q->param(text);
    print("Here's the text you inputted, thanks: $inputText</br>");
    return $inputText;
}
