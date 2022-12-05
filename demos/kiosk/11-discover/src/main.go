package main

import (
	//"encoding/json"
	"net/http"
	"fmt"
	"os/exec"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
	output := execute();


    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write([]byte(output))	
}

func doWebServer() {
	http.HandleFunc("/", homeHandler)	
	http.ListenAndServe(":8011", nil)
}

func main() {
	doWebServer()
}

func execute() string{
	output, err := exec.Command("ohai").Output()

	if err != nil {	
		fmt.Println(err.Error());
	}

	fmt.Println(string(output));

	return string(output);
}