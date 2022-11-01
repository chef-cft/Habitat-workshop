package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

type Location struct {
	Number    string  `json:"Location Number"` //: "ABLI"
	Name      string  `json:"Location Name"`   //: "Abraham Lincoln Birthplace National Historical Park",
	Address   string  `json:"Address"`         //: "2995 Lincoln Farm Road",
	City      string  `json:"City"`            //: "Hodgenville",
	State     string  `json:"State"`           //: "Kentucky",
	ZipCode   int     `json:"Zip Code"`        //: 42748,
	Phone     string  `json:"Phone Number"`    //: "(270) 358-3137",
	Fax       string  `json:"Fax Number"`      //: "(270) 358-3874",
	Latitude  float64 `json:"Latitude"`        //: 37.535671,
	Longitude float64 `json:"Longitude"`       //: -85.7340637,
}

func main() {
	jsonFile, _ := os.Open("national-parks.json")
	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	// we initialize our Users array
	var src []Location
	json.Unmarshal(byteValue, &src)

	fmt.Println("	private static void AppendData(StringBuffer buffer)")
	fmt.Println("    {")

	for index, element := range src {
		element.Name = strings.Replace(element.Name, "\"", " ", -1)
		element.Name = strings.Replace(element.Name, "`", " ", -1)

		element.Address = strings.Replace(element.Address, "\"", " ", -1)
		element.Address = strings.Replace(element.Address, "`", " ", -1)

		element.City = strings.Replace(element.City, "\"", " ", -1)
		element.City = strings.Replace(element.City, "`", " ", -1)

		output, _ := json.Marshal(element)
		temp := strings.Replace(string(output), "\"", "`", -1)
		fmt.Print("        buffer.append(\"")
		if index > 0 {
			fmt.Print(",")
		}
		fmt.Print(temp)
		fmt.Println("\");")
	}

	fmt.Println("	}")

}
