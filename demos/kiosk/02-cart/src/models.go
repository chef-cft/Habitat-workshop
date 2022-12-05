package main

type Product struct {
	ID int `json:"id"`
	Title string `json:"title"`
	Description string `json:"description"`
	Price float32 `json:"price"`
	Image string `json:"image"`
	Category string `json:"category"`
}

type LineItem struct {	
	ID int `json:"id"`
	Title string `json:"title"`
	Description string `json:"description"`
	Price float32 `json:"price"`
	Image string `json:"image"`
	Category string `json:"category"`
	Quantity int `json:"quantity"`
	Amount float32 `json:"amount"`
}

type Order struct {
	Lines []LineItem `json:"lines"`
	Coupon string `json:"coupon"`
	TaxRate float32 `json:"rate"`
	SubTotal float32 `json:"subTotal"`
	EffectiveTotal float32 `json:"effectiveTotal"`
	Discount float32 `json:"discount"`
	DiscountTotal float32 `json:"discountTotal"`
	TaxTotal float32 `json:"taxes"`
	Total float32 `json:"total"`
	Settings Settings `json:"settings"`
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
	Codes []DiscountCode `json:"codes"`
}