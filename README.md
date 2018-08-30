# varnish41-distroless

docker run -it --rm kyos0109/varnish41-distroless:latest varnishd --help

```
docker run --name varnish \
-v $(pwd)/default.vcl:/default.vcl:ro \
-d kyos0109/varnish41-distroless \
varnishd -F -f/default.vcl
```
```
docker exec -it varnish varnishlog
(or other varnish command)
```
