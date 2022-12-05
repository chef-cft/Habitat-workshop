package main
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