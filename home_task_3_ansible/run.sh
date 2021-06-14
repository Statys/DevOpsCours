docker rm openssh-server -f
docker run -d \
  --name=openssh-server \
  -e SUDO_ACCESS=true\
  -e PASSWORD_ACCESS=true\
  -e USER_PASSWORD=1\
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e USER_NAME=us\
  -p 2222:2222 \
  -p 80:80 \
  -v /path/to/appdata/config:/config \
  --restart unless-stopped \
  myopenssh