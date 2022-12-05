package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"fmt"
)

func existsHandler(w http.ResponseWriter, r *http.Request) {
	cart := engine{};
	if( cart.Exists() ) {
		w.WriteHeader(http.StatusOK)
	} else {
		w.WriteHeader(http.StatusNotFound)
	}
}

func addHandler(w http.ResponseWriter, r *http.Request) {
	if( r.Method != http.MethodPost ){
		notFound(w,r);
		return;
	}

	cart := engine{};
	cart.Load();
	var item Product;
    if err := json.NewDecoder(r.Body).Decode(&item); err != nil {
        internalServerError(w, r)
        return
    }	

	cart.Add(item);
	order := cart.Calculate();

	jsonBytes, err := json.Marshal(order)
    if err != nil {
        internalServerError(w, r)
        return
    }

    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func removeHandler(w http.ResponseWriter, r *http.Request) {
	strVar := r.URL.Query().Get("id")
	intVar, cErr := strconv.Atoi(strVar)
	if cErr != nil {
		fmt.Println(cErr);
        notFound(w, r)
        return
    }

	cart := engine{};
	cart.Load();
	cart.Remove(intVar);
	order := cart.Calculate();

	jsonBytes, err := json.Marshal(order)
    if err != nil {
        internalServerError(w, r)
        return
    }

    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}


func couponHandler(w http.ResponseWriter, r *http.Request) {
	strVar := r.URL.Query().Get("code")
	cart := engine{};
	cart.Load();
	cart.Discount(strVar);
	order := cart.Calculate();

	jsonBytes, err := json.Marshal(order)
    if err != nil {
        internalServerError(w, r)
        return
    }

    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func clearHandler(w http.ResponseWriter, r *http.Request) {
	cart := engine{};
	cart.Clear()
	w.WriteHeader(http.StatusOK)
}

func summaryHandler(w http.ResponseWriter, r *http.Request) {
	cart := engine{};
	cart.Load();
	order := cart.Calculate();

	jsonBytes, err := json.Marshal(order)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func internalServerError(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusInternalServerError)
    w.Write([]byte("internal server error"))
}

func notFound(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusNotFound)
    w.Write([]byte("not found"))
}