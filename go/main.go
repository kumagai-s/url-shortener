package main

import (
	"context"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

var (
	s3Client *s3.Client
)

func init() {
	sdkConfig, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		log.Println()
	}
	s3Client = s3.NewFromConfig(sdkConfig)
}

type LambdaRequest struct {
	URL string `json:"url"`
}

func lambdaHandler(r events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{
		Body:       "Hello world !!",
		StatusCode: 200,
	}, nil
	// body := r.Body
	// log.Println("リクエストボディ", body)

	// var lr LambdaRequest
	// if err := json.Unmarshal([]byte(body), &lr); err != nil {
	// 	log.Println()
	// }

	// s3Client.PutObject(context.TODO(), &s3.PutObjectInput{
	// 	Bucket: aws.String(os.Getenv("S3_BUCKET")),
	// })
}

func main() {
	lambda.Start(lambdaHandler)
}
