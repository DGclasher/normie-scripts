package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
)

func checkInput(endpoint string) bool {
	var currencyList map[string]string = getCurrencyList(endpoint)
	if len(os.Args) == 4 {
		arg1 := os.Args[2]
		arg2 := os.Args[3]
		if _, ok := currencyList[arg1]; ok {
			if _, ok := currencyList[arg2]; ok {
				return true
			}
		}
	} else if len(os.Args) == 2 {
		if os.Args[1] == "list" {
			return true
		}
	}
	return false
}

func getCurrencyList(endpoint string) map[string]string {
	resp, err := http.Get(endpoint + "/currencies")
	var currencyList map[string]string
	if err != nil {
		fmt.Println("Error: ", err)
		os.Exit(1)
	} else {
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		errr := json.Unmarshal([]byte(body), &currencyList)
		if err != nil || errr != nil {
			fmt.Println("Error: ", err)
			os.Exit(1)
		}
	}
	return currencyList
}

type ConversionRes struct {
	Amount float64 `json:"amount"`
	Base string `json:"base"`
	Date string `json:"date"`
	Rates map[string]float64 `json:"rates"`
}

func convertCurr(endpoint string) {
	from := os.Args[2]
	to := os.Args[3]
	amount := os.Args[1]
	newEndpoint := endpoint + "/latest?amount=" + amount + "&from=" + from + "&to=" + to
	resp, err := http.Get(newEndpoint)
	if err != nil {
		fmt.Println("Error: ", err)
		os.Exit(1)
	} else {
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			fmt.Println("Error: ", err)
			os.Exit(1)
		}
		var conversion ConversionRes
		err = json.Unmarshal([]byte(body), &conversion)
		if err != nil {
			fmt.Println("Error: ", err)
			os.Exit(1)
		}
		fmt.Println("Amount: ", conversion.Amount)
		fmt.Println("Base: ", conversion.Base)
		fmt.Println("Date: ", conversion.Date)
		fmt.Println("Converted rates: ")
		for key, val := range conversion.Rates {
			fmt.Println(key, " : ", val)
		}
	}
}

func main() {
	endpoint := "https://api.frankfurter.app"
	if !checkInput(endpoint) {
		fmt.Println("Invalid input")
		fmt.Println("Usage: go run main.go <amount> <from> <to> : Convert currenct\n<list> : Get list of currencies")
		os.Exit(1)
	}
	if os.Args[1] == "list" {
		currencyList := getCurrencyList(endpoint)
		for key, val := range currencyList {
			fmt.Println(key, " : ", val)
		}
	}
	if len(os.Args) == 4 {
		convertCurr(endpoint)
	}
}
