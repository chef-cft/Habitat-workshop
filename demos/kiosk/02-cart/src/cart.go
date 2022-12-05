package main

import (
	"encoding/json"
	"io/ioutil"
	"os"
	"errors"
	"strings"
	"net/http"
	"fmt"
	"math"
)

var PORT string = "8004";

type Cart interface {
	Exists() bool
	Load()
	Discount(code string)
	Add(item Product)
	Remove(id int)
	Calculate() Order
	Clear()
}

type engine struct {
    order Order
}

func getSetting() Settings {
	r, err := http.Get( fmt.Sprintf("http://localhost:%s",PORT) )
	if err != nil {
	   fmt.Println(err)
	   return Settings { }
	}

	var settings Settings;

	err = json.NewDecoder(r.Body).Decode(&settings)
    if err != nil {
		fmt.Println(err)
        return Settings { }
    }
	return settings
}

func (e *engine) Exists() bool {
	if _, err := os.Stat("cart.json"); errors.Is(err, os.ErrNotExist) {
		return false;
	}
	return true;	
}

func (e *engine) Load() {
	if e.Exists(){
		jsonFile, _ := os.Open("cart.json")
		byteValue, _ := ioutil.ReadAll(jsonFile)
		defer jsonFile.Close()
		json.Unmarshal(byteValue, &e.order)
		return;
	}
}

func (e *engine) Add(item Product) {
	var found = false;
	order := e.order;

	var items = []LineItem{}
	for _, element := range order.Lines {
		if(element.ID == item.ID){
			
			tmp := element;
			found = true;
			tmp.Quantity += 1;
			tmp.Amount = tmp.Price * float32(tmp.Quantity);
			items = append(items, tmp)

		}else
		{
			items = append(items, element)
		}
	}

	order.Lines = items;

	if(!found){
		newLine := LineItem{ 
			Quantity: 1, 		
			Amount: item.Price,
			ID: item.ID,  
			Title: item.Title,
			Description: item.Description,
			Price: item.Price,
			Image: item.Image,
			Category: item.Category,
			}

		order.Lines = append(order.Lines, newLine);
	}	
	e.order = order;

	e.Save()
}

func (e *engine) Remove(id int) {
	order := e.order;

	var items = []LineItem{}
	for _, element := range order.Lines {
		if(element.ID == id){
			//skip it
		}else
		{
			items = append(items, element)
		}
	}

	order.Lines = items;
	e.order = order;

	e.Save()
}

func (e *engine) Discount(code string) {
	order := e.order;

	order.Coupon = "";
	order.Discount = 0.0;

	if order.Settings.Discount {
		for _, element := range order.Settings.Codes {
			if( strings.ToUpper(element.Code) == strings.ToUpper(code) ){
				order.Coupon = element.Code;
				order.Discount = element.Amount;
			}
		}
	}
	
	e.order = order;
	e.Save()
}

func (e *engine) Calculate() Order {
	order := e.order;

	var amount float32;
	for _, element := range order.Lines {
		amount += element.Amount
	}

	order.SubTotal = amount;
	order.TaxRate = order.Settings.TaxRate;
	order.DiscountTotal = amount * order.Discount
	order.DiscountTotal = float32(math.Floor( float64(order.DiscountTotal) * 100 )/100);
	amount = amount - order.DiscountTotal;
	amount = float32(math.Floor( float64(amount) * 100 )/100);
	order.EffectiveTotal = amount;
	order.TaxTotal = amount * order.TaxRate
	order.TaxTotal = float32(math.Floor( float64(order.TaxTotal) * 100 )/100);
	order.Total = order.SubTotal + order.TaxTotal
	
	return order;	
}

func (e *engine) Clear() {
	if _, err := os.Stat("cart.json"); errors.Is(err, os.ErrNotExist) {
		return;
	}
	os.Remove("cart.json");
	return;	
}


func (e *engine) Save() {
	if !e.Exists(){
		e.order.Settings = getSetting();
	}
	
	file, _ := json.MarshalIndent(e.order, "", " ")
	_ = ioutil.WriteFile("cart.json", file, 0644)
}

