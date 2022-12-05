package main

import (
	"encoding/json"
	"os"
	"errors"
	"io/ioutil"
	"math/rand"
	"time"
//	"os/exec"
//	"strings"
//	"time"
//	"strconv"
//	"path/filepath"
)

func loadHistory() History {
	data := History{}
	if _, err := os.Stat("processor.json"); errors.Is(err, os.ErrNotExist) {
		//do nothing
	} else {
		jsonFile, _ := os.Open("processor.json")
		byteValue, _ := ioutil.ReadAll(jsonFile)
		defer jsonFile.Close()
		json.Unmarshal(byteValue, &data)
	}

	return data
}

func saveHistory(history History) {
	file, _ := json.MarshalIndent(history, "", " ")
	_ = ioutil.WriteFile("processor.json", file, 0644)
}

func appendOrder(order Order) {
	s1 := rand.NewSource(time.Now().UnixNano())
    r1 := rand.New(s1)

	history := loadHistory()
	order.OrderID = r1.Intn(10000)
	history.Active = append(history.Active, order);
	saveHistory(history)
}
	
	