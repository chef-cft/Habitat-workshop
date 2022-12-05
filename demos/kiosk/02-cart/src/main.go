package main

import (
	"net/http"
)

var CONFIG_FILE string = ""

func doWebServer() {
	http.HandleFunc("/exists", existsHandler)
	http.HandleFunc("/coupon", couponHandler)
	http.HandleFunc("/add", addHandler)
	http.HandleFunc("/remove", removeHandler)
	http.HandleFunc("/clear", clearHandler)
	http.HandleFunc("/", summaryHandler)

	http.ListenAndServe(":8002", nil)

}

func main() {
	doWebServer()
}
