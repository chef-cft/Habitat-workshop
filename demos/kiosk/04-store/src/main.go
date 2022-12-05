package main

import (
	"net/http"
	"os"
)

var CONFIG_FILE string = ""

func doWebServer() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8004", nil)
}

func main() {

	if len(os.Args) > 1 {
		CONFIG_FILE = os.Args[1]
		doWebServer()
		return
	}

	doWebServer()
}
