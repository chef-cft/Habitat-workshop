package main

import (
	"encoding/json"
	"net/http"
	"os"
	"fmt"
	"io/ioutil"
)

var CONFIG_FILE string = ""
var SETTINGS Workflow;

func doWebServer() {
	http.HandleFunc("/", statusHandler)
	http.HandleFunc("/start", startOrderHandler)
	http.HandleFunc("/clear", clearHandler)
	http.ListenAndServe(":8003", nil)
}


func loadSetting() {
    jsonFile, err := os.Open(CONFIG_FILE)

    if err != nil {
		fmt.Println(err)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	var cfg Workflow
	json.Unmarshal(byteValue, &cfg)
	SETTINGS = cfg
}


func main() {
	if len(os.Args) > 1 {
		CONFIG_FILE = os.Args[1]
		loadSetting();	
	}

	doWebServer()
}
