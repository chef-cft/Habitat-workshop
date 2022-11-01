package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"net/http"
	"os"
)

type Config struct {
	Color   string `json:"color"`
	Welcome string `json:"welcome"`
}

func cfgHandler(w http.ResponseWriter, r *http.Request) {

	// Open our jsonFile
	jsonFile, err := os.Open(CONFIG_FILE)

	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}

	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()

	// read our opened jsonFile as a byte array.
	byteValue, _ := ioutil.ReadAll(jsonFile)

	// we initialize our Users array
	var cfg Config

	json.Unmarshal(byteValue, &cfg)

	output, _ := json.MarshalIndent(cfg, "", "  ")

	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", string(output)))
	TEMPLATE.Execute(w, Page{Title: "Services", Body: body})

}
