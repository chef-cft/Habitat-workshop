package main

import (
	"fmt"
	"net/http"

	"html/template"
	"os/exec"
)

func coreHandler(w http.ResponseWriter, r *http.Request) {
	out, err := exec.Command("hab", "pkg", "list", "--origin", "core").Output()
	// out, err := exec.Command("hab pkg list --all").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}

	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", string(out)));
	TEMPLATE.Execute(w, Page{Title: "Core Packages", Body: body} )
}

func workshopHandler(w http.ResponseWriter, r *http.Request) {
	out, err := exec.Command("hab", "pkg", "list", "--origin", "workshop").Output()
	// out, err := exec.Command("hab pkg list --all").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}

	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", string(out)));
	TEMPLATE.Execute(w, Page{Title: "Workshop Packages", Body: body} )
}


func packageHandler(w http.ResponseWriter, r *http.Request) {
	out, err := exec.Command("hab", "pkg", "list", "--all").Output()
	// out, err := exec.Command("hab pkg list --all").Output()

	if err != nil {
		fmt.Fprintf(w, "%s", err.Error())
	}

	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", string(out)));
	TEMPLATE.Execute(w, Page{Title: "All Packages", Body: body} )
}
