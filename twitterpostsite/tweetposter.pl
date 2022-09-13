#!/usr/bin/perl -w

use CGI qw/:standard/;
use LWP::UserAgent;
use JSON;
use URI ();
use Data::Dumper;

print "Content-type: text/html\n\n\ \n\n";

print <<ENDHTML;

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--- boot strap's css dependancy + icon dependancy + mapbox CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap\@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymou>
    <link rel="stylesheet" href="../style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons\@1.3.0/font/bootstrap-icons.css">
    <link href='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css' rel='stylesheet' />
    <title>Anthony's Get Site API GET app page</title>
</head>
<body>
    <!-- ### THIS IS OUR NAV BAR ### -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 fixed-top">
        <div class="container">
            <a href="#" class="navbar-brand text-info">Anthony's twitter POST site: app page</a>

            <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navmenu"
            >
            <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navmenu">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a href="#module1" class="nav-link">HomePage</a>
                    </li>
                    <li class="nav-item">
                        <a href="#questions" class="nav-link">twitterpostsite</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ### THIS IS OUR SHOWCASE ### -->
        <section class="bg-dark text-light p-5 p-lg-2 pt-lg-5 text-center text-sm-start" id="showcase">
            <div class="container">
                <div class="d-sm-flex align-items-center justify-content-between">
                    <div class="px-2">
                        <h1 class="text-primary">You're in the <span class="text-warning">API Post Zone

                        </span></h1>
                        <p class="lead my-4">Hit the button below to go back to the index 
                        </p>
                        <form action="index.pl">
                            <button class="btn btn-primary btn-lg my-3"
                            >
                                Go back?
                            </button>
                        </form>
                    </div>
                <p>

ENDHTML

my $apiCallData = makeAPICall();
print("$apiCallData");

print <<ENDHTMLTWO;

</p>
<!-- want the image to show up, 50% ONLY when the screen is bigger than a small screen -->
                    <img class="img-fluid w-50 d-none d-sm-block" src="../img/test.png" alt=""/>
                </div>
            </div>
    </section>


    <!-- FOOTER -->
    <footer class="p-5 bg-dark text-white text-center position-relative">
        <div class="container">
            <p class="lead">Copyright &copy; 2022 Frontend Project</p>
            <a href="#" class="position-absolute bottom-0 end-0 p-5">
                <i class="bi bi-arrow-up-circle h1"></i>
        </div>
    </footer>

    <!-- Modal -->
    <div class="modal fade" id="enroll" tabindex="-1" aria-labelledby="enrollLabel" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title" id="enrollLabel">Modal title</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
            <p class="lead">This would get you to put some detail in, which we would record!</p>
            <form>
                <div class="mb-3">
                    <label for="first-name" class="call-form-label">
                        Your name:
                    </label>
                    <input type="text" class="form-control" id="name" placeholder="Anthony McPerson">
                </div>
                <div class="mb-3">
                    <label for="email" class="call-form-label">
                        Email:
                    </label>
                    <input type="text" class="form-control" id="email" placeholder="anemail\@aplace.someregion">
                </div>
                <div class="mb-3">
                    <label for="phoneNumber" class="call-form-label">
                        Phone number:
                    </label>
                    <input type="text" class="form-control" id="phoneNumber" placeholder="0434 343 434">
                </div>
            </form>
            </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Submit</button>
            </div>
        </div>
        </div>
    </div>

    <!-- bootstraps js dependancy... no need for jquery in v5! And also our mapbox script -->
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap\@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
    <script src='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.js'></script>
    <!-- Need some JS for mapbox too, adding in some extra info to make the map in the correct spot -->
    <script>
        mapboxgl.accessToken = 'pk.eyJ1IjoiYmxvb2RudXQiLCJhIjoiY2w0bXcwdjZpMDBkejNjbm5tZTlpdGZlOCJ9.Wpp_jfcy3xR3Nb7Hb86bVw';
        var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [26, 64],
        zoom: 9
        });
        
    </script>
</body> 
</body>
</html>

ENDHTMLTWO

sub makeAPICall {
    #some basic vars to use
    my $baseUrl = "https://api.twitter.com/2/tweets";

    #taken form previous form
    my $bodyText = capture_input();
    my %jsonArr = ('text' => $bodyText);
    my $bodyTextJSON = encode_json \%jsonArr;
  
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
	# code to pull the current time in epoch
    #my $epoch_timestamp = generate_timestamp();
    #print("the epoch_timestamp variable is: $epoch_timestamp\n");
    
	# code to pull a random nonce
    #my $nonce_string = generate_authstring();
    #print("the nonce_string is: $nonce_string\n");
    $request->header('Accept' => 'application/json');
    $request->header('Content-Type' => 'application/json');
    $request->header('Authorization' => 'OAuth oauth_consumer_key="UvLInXy98PTQg35Ieur99A5SU",
	oauth_token="878484823-8xdfwYTTuixVQRDa4XW1IeNupU5aCl66m0qIBHUk",
	oauth_signature_method="HMAC-SHA1",
	oauth_timestamp="1661266491",
	oauth_version="1.0",
	oauth_nonce="nqEKGAZVpco",
	oauth_signature="AAILK9RysHTSQu%2FnR0YTidvR0xI%3D"');
    $request->content( $bodyTextJSON );

    # pass the request to the obj... see what happens?
    my $response = $ua->request($request);
    my $request_succeeded = 0;

    my $response_value = $response->decoded_content;
    
    my $json_data = from_json($response_value);
    my $errorMsg = $json_data->{errors}->[0]->{message};
	my $failMsg = $json_data->{status};
	#print("my fail message is: $failMsg\n\n");
    my $status_line = $response->status_line;
	#print("The status of the tweet is: $status_line\n\n");
    # handle if tweet can be reached but can't be made
    if($errorMsg){
        print("We hit an auth error for sure $errorMsg </br>");
    }
    # handle if tweet flat out fails
    elsif($failMsg==401){
        print("Dang, the tweet didn't work at all! Ask Anthony to update the nonce/epoch/sig. Go back to index.pl to try again
        </br> ");
    }
    else {
        print("Your tweet worked! Hooray!!! </br>");
        my $tweet_id = $json_data->{data}->{id};
        print("The id of the tweet should be: $tweet_id </br>");
        my $tweet_text = $json_data->{data}->{text};
        print(qq(The message of the tweet you pushed is: "$tweet_text" </br>"));
        print(qq(You can view the tweets to check here: <a href="https://twitter.com/OptimusLimes93" target="_blank" class="link-info">Your tweet</a></br>));
    }
}

sub capture_input {
    my $q = new CGI;
    my $inputText = $q->param(text);
    return $inputText;
}

	#code to get timestamp epoch
sub generate_timestamp {
	my $epochTime = time();
	return $epochTime;
}
	#code to get auth string
sub generate_authstring {
	my @chars = ('0'..'9', 'A'..'F');
	my $len = 10;
	my $randomStr;
	while($len--){ $randomStr .= $chars[rand @chars] };
	return $randomStr;
}
