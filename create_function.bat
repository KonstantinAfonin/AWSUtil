@ECHO OFF

IF "%1" == "--help" (
	ECHO create_function.bat ^<containing folder of the .go program^> ^<name of .go program^> ^<AWS region^> ^<AWS Lambda name^> ^<AWS Role name^>
	GOTO END
)

set GOOS=linux
go build %1\%2.go
del handler.zip
build-lambda-zip -o handler.zip ./%2
aws lambda create-function --region %3 --function-name %4 --memory 128 --role %5 --runtime go1.x --zip-file fileb://handler.zip --handler %2

:END