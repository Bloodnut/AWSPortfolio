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
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons\@1.3.0/font/bootstrap-icons.css">
    <link href='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css' rel='stylesheet' />
    <title>Anthony's Get Site API GET app page</title>
</head>
<body>
    <!-- ### THIS IS OUR NAV BAR ### -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 fixed-top">
        <div class="container">
            <a href="#" class="navbar-brand">Anthony's Get Site API GET app page</a>

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
                <div class="row">
                    <div class="col-6 px-2">
                        <h1 class="text-warning"></br></br>You're in the API GET zone!<span class="text-warning">

                        </span></h1>
                        <p class="lead my-4">Hit the button below to launch the api tweet puller
                        </p>
                        <form action="tweet_grabber.pl">
                            <button class="btn btn-primary btn-lg my-3"
                            >
                                Pull another tweet!
                            </button>
                        </form>             
ENDHTML

my $apiCallData = makeAPICall();
#print("$apiCallData");

print <<ENDHTMLTWO;
                    </div>
                <div class="col-6">
                <img class="img-fluid w-100 d-none d-sm-block" src="../img/test.png" alt=""/>
                </div>	
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


sub makeRandomNumber {
    my $randomNumber = int(rand(100000000));
    return $randomNumber;
}

sub makeAPICall {
   
	my $response_value;
	my $json_data;
	my $successMarker;
        my $twitterSendId = makeRandomNumber();
	my $attemptCounter = 0;
	do{
	    my $baseUrl = "https://api.twitter.com/2/tweets/$twitterSendId";
   	    my %params = (
                "expansions" => "author_id"
	    );

    # get a UA object
    	    my $ua = LWP::UserAgent->new(
            ssl_opts => { verify_hostname => 0 },
            protocols_allowed => ['https'],
    	    );

    # make my modified url using URIcd tw
    	    my $url = URI->new( $baseUrl );
    	    $url->query_form( %params );

    	# assign a request
    	    my $request = HTTP::Request->new(
            "GET",
            "$url",
            HTTP::Headers->new()
    	    );
	    $request->header('Accept' => 'application/json');
            $request->header('Content-Type' => 'application/json');
            $request->header('Authorization' => 'Bearer AAAAAAAAAAAAAAAAAAAAAPp1eAEAAAAANbpGzGfMVavvKE5eDpCXzTl180s%3DZNoq1Cq0CxgVQZ5nLaTLWHxxZWGS2uEbgFdA5PxzqQYyITuaYh');

	    my $response = $ua->request($request);
            $response_value = $response->decoded_content;
            $json_data = from_json($response_value);
            $successMarker = $json_data->{data}->{id};
	    
	    $twitterSendId--;
	    $attemptCounter++;
	    sleep(0.5);
	    } while(!$successMarker);
        
	# print the winner and the counter
	#print("</br> the twitter send ID is now: $twitterSendId");
        #print("</br>My json data var is: $json_data </br>");
	#print("</br>My response value var is: $response_value </br>"); 
        #print("<b>Your tweet worked! Hooray!!!</b> </br>");
        my $tweet_id = $json_data->{data}->{id};
        print(qq(<h3>Nailed it! Your tweet grab worked!</h3></br><b>The id of the tweet should be:</b></br><p class="text-success"> $tweet_id</p>));
        my $tweet_text = $json_data->{data}->{text};
        print("<b>The message of the tweet should be: </b>$tweet_text </br>");
        my $tweet_author = $json_data->{includes}->{users}->[0]->{name};
        print("<b>The author of the tweet should be:</b> $tweet_author </br>");
        my $tweet_authorID = $json_data->{data}->{author_id};
        #print("<b>Their ID is:</b> $tweet_authorID </br>");
	print("</br>It only took <b>$attemptCounter</b> GET requests to work... </br>");
}

