package main

import (
	"fmt"
	"log"
	"math/rand/v2"
	"net/http"
	"time"

	"github.com/getsentry/sentry-go"
)

func main() {
	err := sentry.Init(sentry.ClientOptions{
		Dsn:           "https://bee2e9916643ac084d639071982ca463@o4508677173673984.ingest.de.sentry.io/4508677193072720",
		EnableTracing: true,
		Debug:         true,
		Tags: map[string]string{
			"vendor":   "apple",
			"platform": "macos",
			"arch":     "arm64",
		},
	})

	if err != nil {
		log.Fatalf("sentry.Init: %s", err)
	}

	defer sentry.Flush(2 * time.Second)

	var message []map[string]string

	message = append(message,
		map[string]string{"DEBUG": "Follow your heart"},
		map[string]string{"INFO": "Knowledge is power"},
		map[string]string{"WARNING": "То be or not to be"},
		map[string]string{"ERROR": "Never look back"},
		map[string]string{"CRITICAL": "Let your fears go"})

	for {
		_, err := http.Get("http://localhost:9999")
		if err != nil {
			sentry.CaptureException(err)
		}

		num := rand.IntN(4)
		for key, value := range message[num] {
			sentry.CaptureMessage(fmt.Sprintf("%s %s %s\n", time.Now().Format("2006-01-02 15:04:05.000000 -0700"), key, value))
		}

		time.Sleep(3 * time.Second)
	}
}
