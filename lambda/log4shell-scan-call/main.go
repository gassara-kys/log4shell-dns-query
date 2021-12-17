package main

import (
	"bufio"
	"bytes"
	"context"
	"encoding/json"
	"log"

	l "github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/lambda"
	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
	"github.com/kelseyhightower/envconfig"
)

func main() {
	l.Start(handler)
}

type config struct {
	S3Bucket string `required:"true" split_words:"true"` // S3_BUCKET
	S3Object string `required:"true" split_words:"true"` // S3_OBJECT

	LambdaFunctionName string `required:"true" split_words:"true"`          // LAMBDA_FUNCTION_NAME
	LambdaRegion       string `default:"ap-northeast-1" split_words:"true"` // LAMBDA_REGION
}

type lambdaRequest struct {
	FQDN string `json:"FQDN"`
}

func handler(ctx context.Context) error {
	log.Print("Start log4shell scan caller")
	var conf config
	err := envconfig.Process("", &conf)
	if err != nil {
		log.Fatalf("Failed to load config err=%+v", err)
	}

	// S3
	sess := session.Must(session.NewSessionWithOptions(session.Options{
		SharedConfigState: session.SharedConfigEnable,
	}))
	d := s3manager.NewDownloader(sess)
	buf := aws.NewWriteAtBuffer([]byte{})
	_, err = d.Download(buf, &s3.GetObjectInput{
		Bucket: aws.String(conf.S3Bucket),
		Key:    aws.String(conf.S3Object),
	})
	if err != nil {
		log.Fatalf("Failed to download s3, err=%+v", err)
	}

	// Lambda
	client := lambda.New(sess, &aws.Config{Region: aws.String(conf.LambdaRegion)})
	s := bufio.NewScanner(bytes.NewBuffer(buf.Bytes()))
	for s.Scan() {
		if s.Text() == "" {
			continue
		}
		log.Print(s.Text())
		payload := lambdaRequest{
			FQDN: s.Text(),
		}
		jsonBytes, _ := json.Marshal(payload)
		resp, err := client.Invoke(&lambda.InvokeInput{
			FunctionName:   aws.String(conf.LambdaFunctionName),
			Payload:        jsonBytes,
			InvocationType: aws.String("Event"),
		})
		if err != nil {
			log.Printf("[WARN]Failed to invoke lambda function, err=%+v", err)
		}
		log.Print(resp)
	}
	if s.Err() != nil {
		// non-EOF error.
		log.Fatalf("Failed to read object(non-EOF), err=%+v", s.Err())
	}

	log.Print("End log4shell scan caller")
	return nil
}
