package main

import (
	"bytes"
	"context"
	"crypto/rand"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	"text/template"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

const redirectHTMLTemplate = `
<html>
<head>
  <meta http-equiv="refresh" content="0; url={{.TargetURL}}">
</head>
<body>
</body>
</html>
`

func createRedirectHTML(targetURL string) (string, error) {
	tmpl, err := template.New("redirect").Parse(redirectHTMLTemplate)
	if err != nil {
		return "", err
	}

	data := struct {
		TargetURL string
	}{
		TargetURL: targetURL,
	}

	var buf bytes.Buffer
	err = tmpl.Execute(&buf, data)
	if err != nil {
		return "", err
	}

	return buf.String(), nil
}

type RequestBody struct {
	URL string `json:"url"`
}

func generateRandomString(length int) (string, error) {
	bytes := make([]byte, length)
	_, err := rand.Read(bytes)
	if err != nil {
		return "", err
	}
	return base64.URLEncoding.EncodeToString(bytes)[:length], nil
}

func handleRequest(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	// Parse the request body
	var requestBody RequestBody
	err := json.Unmarshal([]byte(request.Body), &requestBody)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusBadRequest}, err
	}

	// Generate a random string for the object key
	key, err := generateRandomString(8)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	// Create the redirect HTML content
	redirectHTML, err := createRedirectHTML(requestBody.URL)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	// Configure AWS SDK
	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	// Create an S3 client
	client := s3.NewFromConfig(cfg)

	// Upload the redirect HTML to S3
	_, err = client.PutObject(ctx, &s3.PutObjectInput{
		Bucket:      aws.String(os.Getenv("BUCKET_NAME")),
		Key:         aws.String(key),
		Body:        strings.NewReader(redirectHTML),
		ContentType: aws.String("text/html"),
	})
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	// Return the shortened URL
	response := map[string]string{
		"shortened_url": fmt.Sprintf("%s/%s", os.Getenv("APP_URL"), key),
	}
	responseJSON, err := json.Marshal(response)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Headers:    map[string]string{"Content-Type": "application/json"},
		Body:       string(responseJSON),
	}, nil
}

func main() {
	lambda.Start(handleRequest)
}
