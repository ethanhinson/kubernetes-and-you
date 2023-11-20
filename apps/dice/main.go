package main

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"time"
)

// DiceResult represents the result of rolling a dice
type DiceResult struct {
	Roll int `json:"roll"`
}

func rollDice() int {
	rand.Seed(time.Now().UnixNano())
	return rand.Intn(6) + 1 // Rolls a dice (1-6)
}

func diceHandler(w http.ResponseWriter, r *http.Request) {
	result := DiceResult{
		Roll: rollDice(),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
}

func main() {
	http.HandleFunc("/roll-dice", diceHandler)
	fmt.Println("Server starting on port 8080...")
	http.ListenAndServe(":8080", nil)
}
