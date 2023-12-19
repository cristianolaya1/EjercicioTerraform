import boto3
import json

s3_client = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    
    print(event)

    bucket = event['Records'][0]['s3']['bucket']['name']
    
    print("Encontramos el nombre del cubo")
    
    json_file_name = event['Records'][0]['s3']['object']['key']
    
    print("Encontramos la llave")
    
    json_object = s3_client.get_object(Bucket=bucket,Key=json_file_name)
    
    print("Encontramos el fichero")
    
    jsonFileReader = json_object['Body'].read().decode('utf')
    jsonDict = json.loads(jsonFileReader)

    table = dynamodb.Table('formulario')
    table.put_item(Item=jsonDict)

    print("metemos el fichero a la tabla")

    return 'Hello from Lambda'