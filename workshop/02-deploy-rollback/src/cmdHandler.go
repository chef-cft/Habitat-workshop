package main

import (
	"fmt"
	"net/http"

	"html/template"
	"os/exec"
)

func dirHandler(w http.ResponseWriter, r *http.Request) {

	dir, err := exec.Command("dir", "-alR").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}

	pwd, err := exec.Command("pwd").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}


	body := template.HTML(fmt.Sprintf("<span>%s</span><br><pre>%s</pre>", pwd, string(dir)));

	TEMPLATE.Execute(w, Page{Title: "Directory", Body: body} )
}
