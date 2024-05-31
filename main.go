package main

import (
	"fmt"
	"log"
	"os"
)

func main() {

	if len(os.Args) < 2 {
		log.Fatal("Missing arguments")
		os.Exit(1)
	}

	fmt.Print(os.Args[1])

}
