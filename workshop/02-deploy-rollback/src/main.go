package main

import (
	"fmt"
	"net/http"
	"os"
)

var CONFIG_FILE string = ""

func doWebServer() {
	http.HandleFunc("/ping", pingHandler)
	http.HandleFunc("/pkg", packageHandler)
	http.HandleFunc("/pkg/core", coreHandler)
	http.HandleFunc("/pkg/workshop", workshopHandler)
	http.HandleFunc("/svc", servicesHandler)
	http.HandleFunc("/env", envHandler)
	http.HandleFunc("/cfg", cfgHandler)
	http.HandleFunc("/cmd", dirHandler)
	http.HandleFunc("/", homeHandler)

	http.ListenAndServe(":8002", nil)

}

func main() {

	if len(os.Args) > 2 && os.Args[1] == "serve" {
		CONFIG_FILE = os.Args[2]
		doWebServer()
		return
	}

	fmt.Println("test")
}
