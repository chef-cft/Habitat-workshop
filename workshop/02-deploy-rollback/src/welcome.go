package main

const WELCOME string = `
  <div>
  <h4>{{.Welcome}}</h4>
    <div class="container">       
      <div class="row">
      <div class="col-12" style="min-height:200px; background-color: {{.Color}}">
          <p>
            I am currently running version {{.APP_VERSION}} of the application
            using build {{.APP_RELEASE}} and you can change the background color of the application
            in the default.toml. You can also change the welcome message int the toml.
          </p>
        </div>
      </div>
    </div>
  </div>
`
