#!/usr/bin/perl -w

use CGI qw/:standard/;
use strict;
use warnings;


print "Content-type: text/html\n\n; charset=utf-8\n\n";

print <<ENDHTML; 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!--- boot strap's css dependancy + icon dependancy + mapbox CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap\@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons\@1.3.0/font/bootstrap-icons.css">
    <link href='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css' rel='stylesheet' />
    <title>Test App landing site</title>
</head>
<body>
    <!-- ### THIS IS OUR NAV BAR ### -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 fixed-top">
        <div class="container">
            <a href="#" class="navbar-brand">Anthony's template page</a>
            
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
                        <h1>My template <span class="text-warning">
                            BootStrap page
                        </span></h1>
                        <p class="lead my-4">What we should be seeing here is some more text describing the app we are in. 
                        </p>
                        <button class="btn btn-primary btn-lg" 
                        data-bs-toggle="modal"
                        data-bs-target="#enroll"
                        >
                            A useless button!
                        </button>
                        <form action="">
                            <button class="btn btn-primary btn-lg my-3" 
                            >
                                A button that does something!
                            </button>
                        </form>
                        <form action="">
                            <button class="btn btn-primary btn-lg my-3" 
                            >
                                Another button that may also do something?
                            </button>
                        </form>
                    </div>
                    <!-- want the image to show up, 50% ONLY when the screen is bigger than a small screen -->
                    <img class="img-fluid w-50 d-none d-sm-block" src="img/test.png" alt=""/>
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
                    <input type="text" class="form-control" id="email" placeholder="anemailATaplace.someregion">
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
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
ENDHTML
