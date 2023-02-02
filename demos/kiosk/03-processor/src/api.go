package main

import (
	"encoding/json"
	"net/http"
	"fmt"
	"os"
)

var PORT string = "8002";
func getOrder() Order {
	r, err := http.Get( fmt.Sprintf("http://localhost:%s",PORT) )
	if err != nil {
	   fmt.Println(err)
	   return Order { }
	}

	var order Order;

	err = json.NewDecoder(r.Body).Decode(&order)
    if err != nil {
		fmt.Println(err)
        return Order { }
    }
	return order
}

func clearOrder() {
	_, _ = http.Get( fmt.Sprintf("http://localhost:%s/clear",PORT) )
}


func statusHandler(w http.ResponseWriter, r *http.Request) {
	data := loadHistory()
    jsonBytes, _ := json.MarshalIndent(data, "", "  ")
	w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)
}

func startOrderHandler(w http.ResponseWriter, r *http.Request) {
	order := getOrder()
	if len(order.Lines) > 0 {
		clearOrder()
		appendOrder(order)
	}

	statusHandler(w, r);
}
	
func clearHandler(w http.ResponseWriter, r *http.Request) {
	os.Remove("processor.json");
    w.WriteHeader(http.StatusOK)
}
