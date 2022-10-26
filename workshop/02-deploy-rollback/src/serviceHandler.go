package main

import (
	"fmt"
	"net/http"

	"html/template"
	"os/exec"
)

func servicesHandler(w http.ResponseWriter, r *http.Request) {
	out, err := exec.Command("hab", "svc", "status").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}

	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", string(out)));
	TEMPLATE.Execute(w, Page{Title: "Services", Body: body} )
}
