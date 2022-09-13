#!/usr/bin/perl -l

use CGI qw/:standard/;
use LWP::UserAgent;
use JSON;
use URI ();
use Data::Dumper;


my $apiCallData = makeAPICall();
print("$apiCallData");


sub makeAPICall {
    #some basic vars to use
    my $baseUrl = "https://api.twitter.com/2/tweets";

    #taken form previous form - not needed for dummy
    my $bodyText = capture_input();
    my %jsonArr = ('text' => $bodyText);
    my $bodyTextJSON = encode_json \%jsonArr;

    print("Here's our JSON $bodyTextJSON\n\n");
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
    my $epoch_timestamp = generate_timestamp();
    print("the epoch_timestamp variable is: $epoch_timestamp\n");

    my $nonce_string = generate_authstring();
    print("the nonce_string is: $nonce_string\n");
    $request->header('Accept' => 'application/json');
    $request->header('Content-Type' => 'application/json');
    $request->header('Authorization' => 'OAuth oauth_consumer_key="UvLInXy98PTQg35Ieur99A5SU",oauth_token="878484823-8xdfwYTTuixVQRDa4XW1IeNupU5aCl66m0qIBHUk",
    oauth_signature_method="HMAC-SHA1",
    oauth_timestamp="$epoch_timestamp",
    oauth_version="1.0",
    oauth_nonce="$nonce_string",
    oauth_signature="TDB6xjYXx0jZ8w9F5mxczwYhIpg%3D"');
    $request->content( $bodyTextJSON );

    # pass the request to the obj... see what happens?
    my $response = $ua->request($request);
    my $request_succeeded = 0;

    my $response_value = $response->decoded_content;
    my $json_data = from_json($response_value);
    my $errorMsg = $json_data->{errors}->[0]->{message};
        print("my error message is: $errorMsg \n\n");
    my $failMsg = $json_data->{status};
        print("my fail message is: $failMsg\n\n");
    my $status_line = $response->status_line;
        print("The status of the tweet is: $status_line\n\n");
    # handle if tweet can be reached but can't be made
    if($errorMsg){
        print("We hit an auth error for sure $errorMsg </br>");
    }
    # handle if tweet flat out fails
    elsif($failMsg==401){
        print("Dang, the tweet didn't work at all! Go back to index.pl to try again
        </br>");
    }
    else {
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
    print("Here's the text you inputted, thanks: $inputText\n\n</br>");
    return $inputText;
}

sub generate_timestamp {
        my $epochTime = time();
        return $epochTime;
}

sub generate_authstring {
        my @chars = ('0'..'9', 'A'..'F');
        my $len = 10;
        my $randomStr;
        while($len--){ $randomStr .= $chars[rand @chars] };
        return $randomStr;
}

	
