Build the Docker Image

```shell
docker build -t mynginxserver .
```

Check image was built succesffully 

```shell
docker image ls | grep mynginxserver
```

Run the Docker Image on port 80

```shell
docker run -d -p 80:80 mynginxserver
```

cURL localhost

```shell
curl -i localhost:80
HTTP/1.1 200 OK
Server: nginx/1.19.2
Date: Sun, 06 Sep 2020 13:11:10 GMT
Content-Type: text/html
Content-Length: 117
Last-Modified: Sun, 06 Sep 2020 13:06:54 GMT
Connection: keep-alive
ETag: "5f54deee-75"
Accept-Ranges: bytes

<!DOCTYPE html>
<html lang="en">
<body>
    
    <img src="hello_world.png" alt="Hello world image">

</body>
</html>
```