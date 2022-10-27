package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	
	port := "8080";
	if len(os.Args) > 1 {
		port = os.Args[1];
	}

	contents := `<html>
	<body>
		Welcome to Habitat
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
		w.Write([]byte(contents))
	});

	http.ListenAndServe(":" + port, nil)

}
