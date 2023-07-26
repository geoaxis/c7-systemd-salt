##Why 
I needed a CentOS 7 (x86)  based salt stack test setup that worked on docker for Mac (M1). This recepie build a container with salt stack baked. I have tested it on Mac M1 machine.

##Build 

```
docker buildx build --no-cache -t local/c7-systemd-salt  --platform linux/amd64 .
```

##Run 

```
docker-compose up 
```



