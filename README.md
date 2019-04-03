# DevSpace for PHP and MySql developer environment.

* PHP v7.1


## Getting Started

1. First install DevSpaces client application, follow the instructions [here](https://support.devspaces.io/article/22-devspaces-client-installation) to do this.

2. Clone this repository locally

3. To create a DevSpace, open a terminal then navigate to the cloned repository directory and run following command
```bash
devspaces create
```
This will open a build status window and shows you the progress of DevSpace creation. Once build is successful validated starts.

4. Once validation is completed. Run `devspaces ls` command to see the list of DevSpaces and corresponding status. Newly created DevSpace `php-mysql` will be in "**Stopped**" status.

5. To start your DevSpace run following command
```bash
devspaces start php-mysql
```
You will receive a notification when your DevSpace is ready to be used.

6. To get inside your DevSpace, run following command
```bash
devspaces exec php-mysql
```

## Run Demo PHP Slim Application with MySql and Nginx

1. From a new terminal, clone the demo application repository
```bash
git clone https://github.com/anychart-integrations/php-slim-mysql-template.git
```

2. Navigate to cloned demo application directory
```bash
cd php-slim-mysql-template
```

3. To synchronization code from your local machine to your DevSpace. Run following command
```bash
devspaces bind php-mysql
```
This will synchronize files from your current working directory to your DevSpace. It might takes some time to complete, depending on the repository size.

4. Get inside your DevSpace by running following command
```bash
devspaces exec php-mysql
```
5. Once you're inside DevSpace, you should be able see `php-slim-mysql-template` project files under `/data` directory.

6. Install dependencies
```bash
php composer.phar install
```

7. Prepare database
```bash
mysql < database_backup.sql
```

8. Create a file `/etc/nginx/conf.d/slim.conf` with the following content.

```bash
upstream devspace-app {
  server localhost:8080;
}

server {
  listen 80;

  server_name localhost;
  client_max_body_size 200M;

  location / {

    proxy_redirect off;
    proxy_set_header   Host  $host;
    proxy_pass http://devspace-app;
    proxy_read_timeout 1800s;

  }
}
```

9. Comment the following line in `/etc/nginx/nginx.conf`
```bash
# include /etc/nginx/sites-enabled/*;
```

10. Apply changes in Nginx:
```bash
/etc/init.d/nginx reload
```

11. Run the project
```bash
cd public
php -S localhost:8080
```

Now application is running and Nginx exposes that to port 80. To get the public URL exposed by DevSpace run following command from your local terminal `devspaces info php-mysql`. Then open URL under URLs section in your browser to access the application.
