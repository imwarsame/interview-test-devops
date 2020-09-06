import os
import boto3
from requests_aws4auth import AWS4Auth
from elasticsearch import Elasticsearch, RequestsHttpConnection
import curator

def ecs_cleanup():
    es_host = os.environ['ES_HOST']
    region =os.environ['REGION']
    retention_days = int(os.environ['RETENTION_DAYS'])
    service = 'es'
    credentials = boto3.Session().get_credentials()
    awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)



    es = Elasticsearch(
        hosts=[{'host': es_host, 'port': 443}],
        http_auth=awsauth,
        use_ssl=True,
        verify_certs=True,
        connection_class=RequestsHttpConnection,
        timeout=30,
        max_retries=10,
        retry_on_timeout=True
    )

    index_list = curator.IndexList(es)
    index_list.filter_by_age(source='name', direction='older', timestring='%Y.%m.%d', unit='days', unit_count=retention_days)
    
    print("Found %s indices to delete" % len(index_list.indices))
    print(index_list.indices)

    if index_list.indices:
        curator.DeleteIndices(index_list).do_action()

def main():
    ecs_cleanup()

if __name__ == "__main__":
    main()