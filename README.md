# landoScript

Place the file inside 

```
~/devscripts/newlando.sh
```

```
chmod +x ~/devscripts/newlando.sh
```

edit *.zshrc* to include

```
alias newlando="$HOME/devscripts/newlando.sh"
```

## Complete .lando.yml example
```yaml
name: honeyhouseuae
recipe: wordpress
config:
  webroot: wordpress
  php: "8.3"
services: 
  phpmyadmin: 
    type: phpmyadmin
  mailhog:
    type: mailhog
```
