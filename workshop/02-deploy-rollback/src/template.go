package main

import "html/template"

type Page struct {
	Title string
	Body  template.HTML
}

const WEBSITE string = `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Edge Management Workshop</title>
    <!-- Bootstrap core CSS -->
	  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  </head>

  <body>
    <div class="navbar-wrapper">
      <div class="container">
          <h1>Edge Management Workshop</h1>
          <hr/>
      </div>
    </div>

    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container">
        
      <div class="row">
        <div class="col-2">
          <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/ping">Ping</a></li>
            <li><a href="/cfg">Configuration</a></li>
            <li><a href="/pkg">Packages</a>
              <ul>
                <li><a href="/pkg/core">Origin: Core</a></li>
                <li><a href="/pkg/workshop">Origin: Workshop</a></li>
              </ul>
            </li>
            <li><a href="/svc">Services</a></li>
            <li><a href="/env">Enviornment</a></li>
            <li><a href="/cmd">Directory</a></li>
          </ul>
        </div>
        <div class="col-10">
          <h2>{{.Title}}</h2>
          <br/>
          <hr/>
          <br/>
          {{.Body}}
        </div>
      </div>
    </div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
  </body>
</html>`
