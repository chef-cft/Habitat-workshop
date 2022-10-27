package main

import (
	"fmt"
	"net/http"
	"strings"
	"os"
	"os/exec"
)

func main() {
	
	port := "8080";
	if len(os.Args) > 1 {
		port = os.Args[1];
	}

	contents := `<html>
	<body>
		<h1>Welcome to Habitat</h1>

		<div>
			<pre>
<!--SERVICES-->
			<pre>
		</div>
	</body>
</html>`;

	if len(os.Args) > 2 {
		b, err := os.ReadFile(os.Args[2])
		if err != nil {
			fmt.Println(err)			
		}else{
			contents = string(b)
		}

	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) { 
		body := strings.Replace(contents, "<!--SERVICES-->", services(), -1);
		w.Write([]byte(body))
	});

	http.ListenAndServe(":" + port, nil)
}

func services() string {
	out, err := exec.Command("hab", "svc", "status").Output()

	if err != nil {
		return ""
	}
	
	return string(out);
}
