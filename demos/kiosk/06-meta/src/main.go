package main

import (
	"net/http"
)

var CONFIG_FILE string = ""

func doWebServer() {
	http.HandleFunc("/", statusHandler)
	http.HandleFunc("/ring", ringHandler)
	http.HandleFunc("/services", servicesHandler)
	http.HandleFunc("/packages", packageHandler)
	http.HandleFunc("/versions", versionHandler)
	
	http.ListenAndServe(":8006", nil)
}

func main() {
	doWebServer()
}
