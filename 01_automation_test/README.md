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
curl localhost:80
<!DOCTYPE html>
<html lang="en">
<body>
    
    <h1>
        Hello World
    </h1>

</body>
</html>
```