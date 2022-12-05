package main

import (
	"encoding/json"
	"net/http"
	"io/ioutil"
	"fmt"
	"os/exec"
	"os"
	"strings"
	"time"
	"strconv"
	"path/filepath"
)

func handler(w http.ResponseWriter, r *http.Request) {
    if r.URL.Path != "/" {
		http.Error(w, "404 not found.", http.StatusNotFound)
		return
	}

    switch r.Method {
        case "GET":		
            getHandler(w, r);
    	case "POST":
            postHandler(w, r);

    	default:
	    	http.Error(w, "405 verb not allowed.", http.StatusMethodNotAllowed)
	}
}

func loadSetting() Settings {
    jsonFile, err := os.Open(CONFIG_FILE)

    if err != nil {
		fmt.Println(err)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	var cfg Settings
	json.Unmarshal(byteValue, &cfg)
	return cfg
}

func getHandler(w http.ResponseWriter, r *http.Request) {
	cfg := loadSetting();

    jsonBytes, _ := json.MarshalIndent(cfg, "", "  ")
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}


func postHandler(w http.ResponseWriter, r *http.Request) {
	var req Settings
	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
	 http.Error(w, err.Error(), http.StatusBadRequest)
	 return
	}

	cfg := loadSetting();
    var sb strings.Builder

	if req.StoreID > 0{
		sb.WriteString("storeId=");
		sb.WriteString( fmt.Sprintf("%d",req.StoreID));
		sb.WriteString("\n");

		sb.WriteString("catalog=\"");
		sb.WriteString(req.Catalog);
		sb.WriteString("\"\n");

		sb.WriteString("TaxRate=");
		sb.WriteString( fmt.Sprintf("%f",req.TaxRate));
		sb.WriteString("\n");

		sb.WriteString("discount=");
		sb.WriteString( fmt.Sprintf("%t",req.Discount));
		sb.WriteString("\n");
	}else{
		sb.WriteString("storeId=");
		sb.WriteString( fmt.Sprintf("%d",cfg.StoreID));
		sb.WriteString("\n");

		sb.WriteString("catalog=\"");
		sb.WriteString(cfg.Catalog);
		sb.WriteString("\"\n");

		sb.WriteString("TaxRate=");
		sb.WriteString( fmt.Sprintf("%f",cfg.TaxRate));
		sb.WriteString("\n");

		sb.WriteString("discount=");
		sb.WriteString( fmt.Sprintf("%t",cfg.Discount));
		sb.WriteString("\n");
	}

	if len(req.Codes) > 0{
		for _, line := range req.Codes {
			sb.WriteString("[[codes]]\n");
			sb.WriteString( fmt.Sprintf("code=\"%s\"\n",line.Code) );
			sb.WriteString( fmt.Sprintf("amount=%f\n",line.Amount) );				
		}
	}else{
		for _, line := range cfg.Codes {
			sb.WriteString("[[codes]]\n");
			sb.WriteString( fmt.Sprintf("code=\"%s\"\n",line.Code) );
			sb.WriteString( fmt.Sprintf("amount=%f\n",line.Amount) );				
		}
	}

    w.Header().Set("Content-Type", "text/plain; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write( []byte(sb.String()))	
	
	updateSettings(sb.String());
}

func getServiceGroup() (string, string, string, string) {
	output, _ := exec.Command("hab", "svc", "status").Output();

	lines := strings.Split( strings.ReplaceAll(string(output), "\r\n", "\n"), "\n");
	lines = lines[1:];

	for _, line := range lines {
		parts := strings.Fields(line);

		if len(parts) == 7 {
			pkg := strings.Split(parts[0], "/");
			group := strings.Split(parts[6], ".");

			if pkg[1] == "kiosk_store" {
				return pkg[0], pkg[1], group[0], group[1];
			}
		}
	}

	return "", "", "", "";
}

func createFile(data string) string {
	
	f, err := os.Create("settings.toml")
    if err != nil {
        fmt.Println(err)
    }
    defer f.Close()
    f.WriteString(data);

	abs, _ := filepath.Abs("settings.toml")
	return abs;
}

func updateSettings(data string) {
	fileName := createFile(data);
	_, _, service, group := getServiceGroup();
	serviceGroup := fmt.Sprintf("%s.%s", service, group);
	version := strconv.FormatInt(time.Now().UTC().UnixNano(), 10);
	exec.Command("hab", "config", "apply", serviceGroup, version, fileName).Output()
}