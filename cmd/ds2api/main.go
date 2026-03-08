package main

import (
	"log"
	"net/http"
	"os"

	"ds2api/app"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "10000"
	}

	handler := app.NewHandler()
	
	log.Printf("Server starting on port %s", port)
	if err := http.ListenAndServe(":"+port, handler); err != nil {
		log.Fatal(err)
	}
}
