package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
	"time"

	"html/template"
)

var TEMPLATE *template.Template

func init() {
	tpl := template.New("Website")
	TEMPLATE, _ = tpl.Parse(WEBSITE)
}


func pingHandler(w http.ResponseWriter, r *http.Request) {
	currentTime := time.Now()
	body := template.HTML(fmt.Sprintf("<pre>%s</pre>", currentTime.Format("2006-01-02 15:04:05 Monday")))
	TEMPLATE.Execute(w, Page{Title: "Services", Body: body})
}

func homeHandler(response http.ResponseWriter, request *http.Request) {
	var cfg Config
	data := make(map[string]string)

	jsonFile, err := os.Open(CONFIG_FILE)
	if err != nil {
		fmt.Println(err)
	}
	defer jsonFile.Close()
	byteValue, _ := ioutil.ReadAll(jsonFile)
	json.Unmarshal(byteValue, &cfg)

	env := os.Environ()
	for _, envVar := range env {
		parts := strings.Split(envVar, "=")

		if parts[0] == "APP_VERSION" {
			data["APP_VERSION"] = parts[1]
			continue
		}

		if parts[0] == "APP_RELEASE" {
			data["APP_RELEASE"] = parts[1]
			continue
		}
	}

	data["Color"] = cfg.Color
	data["Welcome"] = cfg.Welcome

	var tpl bytes.Buffer

	tplBody, _ := template.New("").Parse(WELCOME)
	tplBody.Execute(&tpl, data)

	body := tpl.String()

	TEMPLATE.Execute(response, Page{Title: "Home", Body: template.HTML(body)})
}

func envHandler(w http.ResponseWriter, r *http.Request) {
	env := os.Environ()
	message := ""

	for _, envVar := range env {
		parts := strings.Split(envVar, "=")

		if parts[0] == "LS_COLORS" {
			continue
		}
		message += parts[0]
		message += "="
		message += strings.Join(parts[1:], "=")
		message += "<br/>"
	}

	body := template.HTML(message)
	TEMPLATE.Execute(w, Page{Title: "Services", Body: body})
}
