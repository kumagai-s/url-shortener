package main

import (
	"bytes"
	"context"
	"crypto/rand"
	"encoding/json"
	"fmt"
	"log"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type RequestBody struct {
	Url string `json:"url"`
}

func generateRandomKey() (string, error) {
	keySize := 8
	bytes := make([]byte, keySize)
	_, err := rand.Read(bytes)
	if err != nil {
		return "", err
	}
	return fmt.Sprintf("%x", bytes), nil
}

func handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var requestBody RequestBody
	err := json.Unmarshal([]byte(request.Body), &requestBody)
	if err != nil {
		log.Printf("Error unmarshalling request body: %v", err)
		return events.APIGatewayProxyResponse{StatusCode: 400}, err
	}

	cfg, err := config.LoadDefaultConfig(ctx, config.WithRegion("ap-northeast-1"))
	if err != nil {
		log.Printf("Error loading config: %v", err)
		return events.APIGatewayProxyResponse{StatusCode: 500}, err
	}

	svc := s3.NewFromConfig(cfg)

	bucket := os.Getenv("BUCKET_NAME")
	key, err := generateRandomKey()
	if err != nil {
		log.Printf("Error generating random key: %v", err)
		return events.APIGatewayProxyResponse{StatusCode: 500}, err
	}

	redirectURL := requestBody.Url

	_, err = svc.PutObject(ctx, &s3.PutObjectInput{
		Bucket: aws.String(bucket),
		Key:    aws.String(key),
		Body:   bytes.NewReader([]byte("")),
		Metadata: map[string]string{
			"x-amz-website-redirect-location": redirectURL,
		},
	})

	if err != nil {
		log.Printf("Error uploading object to S3: %v", err)
		return events.APIGatewayProxyResponse{StatusCode: 500}, err
	}

	shortenedURL := fmt.Sprintf("%s/%s", os.Getenv("APP_URL"), key)

	return events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body:       shortenedURL,
	}, nil
}

func main() {
	lambda.Start(handler)
}
