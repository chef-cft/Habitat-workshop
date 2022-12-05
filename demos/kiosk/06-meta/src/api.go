package main

import (
	"encoding/json"
	"net/http"
	//"strconv"
	//"fmt"
)

func ringHandler(w http.ResponseWriter, r *http.Request) {
	hab := engine{};
	status := hab.Ring();

	jsonBytes, err := json.Marshal(status)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}


func versionHandler(w http.ResponseWriter, r *http.Request) {
	hab := engine{};
	status := hab.Versions();

	jsonBytes, err := json.Marshal(status)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func statusHandler(w http.ResponseWriter, r *http.Request) {
	hab := engine{};
	status := hab.Status();

	jsonBytes, err := json.Marshal(status)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func packageHandler(w http.ResponseWriter, r *http.Request) {
	hab := engine{};
	status := hab.Packages();

	jsonBytes, err := json.Marshal(status)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}


func servicesHandler(w http.ResponseWriter, r *http.Request) {
	hab := engine{};
	status := hab.Services();

	jsonBytes, err := json.Marshal(status)
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