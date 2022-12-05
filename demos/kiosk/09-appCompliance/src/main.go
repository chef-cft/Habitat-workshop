package main

import (
	"net/http"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"time"
	"encoding/json"
	"strings"
	"errors"
	"io/ioutil"	
)

func execute(){
	IS_RUNNING = true;

	fmt.Print(HTTP_PORT)
	fmt.Print(": LAST_TICK = ")
	fmt.Println(LAST_TICK)

	fmt.Print(HTTP_PORT)
	fmt.Print(": NEXT_TICK = ")
	fmt.Println(NEXT_TICK)

	output, err := exec.Command(COMMAND, ARGUMENTS...).Output()

	if err != nil {
		fmt.Print(HTTP_PORT)
		fmt.Println(": ERROR");
	
		fmt.Print(HTTP_PORT)
		fmt.Print(":")
		fmt.Println(err.Error());

		fmt.Print(HTTP_PORT)
		fmt.Println(": -------------")
		fmt.Println(string(output));	
		fmt.Print(HTTP_PORT)
		fmt.Println(": -------------")
	}

	f, _ := os.Create(fmt.Sprintf("%s/output.txt",OUTPUT_DIR))

    defer f.Close()

    f.WriteString(string(output))


	fmt.Print(HTTP_PORT)
	fmt.Println(": completed");

	IS_RUNNING = false;
}








/***** HTTP ****/


func runHandler(w http.ResponseWriter, r *http.Request) {
	if !IS_RUNNING{
		go execute();
		w.WriteHeader(http.StatusAccepted)
		w.Write([]byte("Started"))	
	}else{
		w.WriteHeader(http.StatusAlreadyReported)
		w.Write([]byte("Already Running"))
	}
}


func homeHandler(w http.ResponseWriter, r *http.Request) {
	status := make(map[string]interface{});
    status["lastRun"] = LAST_TICK
    status["nextRun"] = NEXT_TICK
    status["active"] = TICK_ACTIVE
    status["running"] = IS_RUNNING
    status["command"] = COMMAND[strings.LastIndex(COMMAND, "/")+1:]
    status["duration"] = DURATION
    status["path"] = OUTPUT_DIR
    
	jsonBytes, err := json.Marshal(status)
    if err != nil {
        internalServerError(w, r)
        return
    }
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(http.StatusOK)
    w.Write(jsonBytes)	
}

func toggleHandler(w http.ResponseWriter, r *http.Request) {
    TICK_ACTIVE = !TICK_ACTIVE;
    homeHandler(w, r);
}

func reportHandler(w http.ResponseWriter, r *http.Request) {        
    files := []string{}
    rpt := r.URL.Query().Get("report")  
    if rpt == "" {
        flist, _ := ioutil.ReadDir(OUTPUT_DIR)

        for _, f := range flist {
            files = append(files, f.Name())
        }

	    jsonBytes, err := json.Marshal(files)
        if err != nil {
            internalServerError(w, r)
            return
        }

        w.Header().Set("Content-Type", "application/json; charset=utf-8")
        w.WriteHeader(http.StatusOK)
        w.Write(jsonBytes)

        return;
    }

    file := fmt.Sprintf("%s%s",OUTPUT_DIR,rpt);
    fmt.Println(file);
    if _, err := os.Stat(file); errors.Is(err, os.ErrNotExist) {
        notFound(w,r)
    } else {
        fileBytes, _ := ioutil.ReadFile(file)
        //	w.Header().Set("Content-Type", "application/octet-stream")
        w.Write(fileBytes)
    }
}



func internalServerError(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusInternalServerError)
    w.Write([]byte("internal server error"))
}

func notFound(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusNotFound)
    w.Write([]byte("not found"))
}




/***** MAIN ****/


var HTTP_PORT string = "8008"
var OUTPUT_DIR string = ""

func doWebServer() {
	http.HandleFunc("/", homeHandler)	
	http.HandleFunc("/toggle", toggleHandler)	
	http.HandleFunc("/report", reportHandler)	
	http.HandleFunc("/run", runHandler)	
	http.ListenAndServe(fmt.Sprintf(":%s",HTTP_PORT), nil)
}

var COMMAND string
var ARGUMENTS []string
var DURATION int = 60;
func main() {

	if len(os.Args) >= 6{
		HTTP_PORT = os.Args[1]
		i64, _ := strconv.ParseInt(os.Args[2], 10, 32)
		DURATION = int(i64);
		OUTPUT_DIR = os.Args[3];
		COMMAND = os.Args[4];
		ARGUMENTS = os.Args[5:];
	}else{
		fmt.Print("COMMAND DISABLED")
	}

	fmt.Println("HTTP_PORT", HTTP_PORT)
	fmt.Println("OUTPUT_DIR", OUTPUT_DIR)
	fmt.Println("DURATION", DURATION)
	fmt.Println("COMMAND", COMMAND)
	fmt.Println("ARGUMENTS", ARGUMENTS)


	go timer(DURATION, execute)
	doWebServer()
}


/***** TIMER ****/


var LAST_TICK time.Time
var NEXT_TICK time.Time
var TICK_ACTIVE bool = true
var IS_RUNNING bool = false

func timer(interval int, runMethod func()) {
	duration := time.Duration(interval) * time.Second;

	for tick := range time.Tick( duration ) {
		NEXT_TICK = tick.Add(duration);
		if !TICK_ACTIVE {
			fmt.Println("interval is disabled")
			continue;
		}
		LAST_TICK = tick

		if !IS_RUNNING{
			runMethod();
		}else{
			fmt.Println("skipping this interval already running")
		}
    }
}