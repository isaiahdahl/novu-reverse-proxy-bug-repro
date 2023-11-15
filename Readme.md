Reverse proxy setup:

add `mysite.localhost` to your hosts file and point it to 

```
127.0.0.1    mysite.localhost
```

Clone the novu repo in the sites folder so when you make changes locally you can just change the docker-compose.yml to build from that folder locally instead of the remote image. Serves the purpose of creating a faster local testing of this NGINX setup.
```
cd sites

git clone https://github.com/novuhq/novu 

```

the novu-web container is an example of this.



THe docker-compose file is basicaly a copy of what's in `/docker/local/deployment` of the novu repo.

The main difference is a NGINX container which tries to run the novu locally behind a reverse proxy.

This repo was setup so that I could validate that I could run novu with a GLOBAL_CONTEXT_PATH

MY objective is to run novu behind a reverse proxy that sends everything from mysite.com/novu to the rspective novu containers. Which is implied to be possible here: https://docs.novu.co/self-hosting-novu/deploy-with-docker#reverse-proxy-load-balancers


The env.example should have the environment varialbes setup correctly as if you were to run all of the novu services behind a load balancer like is documented. 

THe nginx container is a bit overkill for a local example as it's just a stripped down version of what I would run in production. but it does work. 

The ./docker-images/nginx/sites-enabled/mysite.localhost.conf is where the novu stuff is

This repo should just work completely by running `docker-compose up -d` and then visiting http://mysite.localhost/novu in your browser.

But it doesn't.