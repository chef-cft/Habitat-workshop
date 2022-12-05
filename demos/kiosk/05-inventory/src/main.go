package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	"errors"
	"os"
	"strings"
	"io/ioutil"
)

var CATALOG string = "default";
var PORT string = "8004";

func prepareCatalog() {
	r, err := http.Get( fmt.Sprintf("http://localhost:%s",PORT) )
	if err != nil {
	   fmt.Println(err)
	   return
	}

	var settings Settings;

	err = json.NewDecoder(r.Body).Decode(&settings)
    if err != nil {
		fmt.Println(err)
        return
    }

	CATALOG = settings.Catalog;
}

func homeHandler(w http.ResponseWriter, r *http.Request) {

	prepareCatalog();
	filePath := fmt.Sprintf("data/%s.json", CATALOG);
	fileBytes, _ := ioutil.ReadFile(filePath)

    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(fileBytes)	
}


func imagesHandler(w http.ResponseWriter, r *http.Request) {
	parts := strings.Split(r.URL.Path, "/")

	fileName := parts[len(parts)-1];
	filePath := fmt.Sprintf("data/images/%s", fileName);
	if _, err := os.Stat(filePath); errors.Is(err, os.ErrNotExist) {
		notFound(w, r)
		return
	  }

	w.WriteHeader(http.StatusOK)
  	if strings.HasSuffix(r.URL.Path, ".png") {
	    w.Header().Set("Content-Type", "image/png")
	}else{
	    w.Header().Set("Content-Type", "image/jpeg")
	}

	fileBytes, _ := ioutil.ReadFile(filePath)
	w.Write(fileBytes)	
}


func notFound(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusNotFound)
    w.Write([]byte("not found"))
}


func doWebServer() {
	http.HandleFunc("/", homeHandler)	
	http.HandleFunc("/images/", imagesHandler)	
	http.ListenAndServe(":8005", nil)
}

func main() {
	if len(os.Args) > 2 {
		CATALOG = os.Args[2] 
	}

	if len(os.Args) > 1 {
		PORT = os.Args[1] 
	}

	doWebServer()
}

type DiscountCode struct {
	Code string `json:"code"`
	Amount float32 `json:"amount"`
}

type Settings struct {
	StoreID int `json:"storeId"`
	Catalog string `json:"catalog"`
	TaxRate float32 `json:"taxRate"`
	Discount bool `json:"discount"`
	Code []DiscountCode `json:"codes"`
}