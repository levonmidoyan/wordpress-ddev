DDEV setup for WordPress
===

### Installation
- Download zip or clone repo.
- Run following.

But before you start make sure you have installed these CLIs:
- ddev CLI. You can find the installation guide [here](https://ddev.com/get-started/) 
  or check the GitHub [repository](https://github.com/ddev/ddev).
- ahoy CLI. Check the GitHub [repository](https://github.com/ahoy-cli/ahoy) 

```bash
ahoy init
```
After initialization run this command:

```bash
ahoy start
```

That's it.

The local domain for your WordPress site is
```
https://wpfordev.ddev.site
```

> [!NOTE]
> You can change the domain from **/.ddev/config.yaml** file


### Author
Levon Midoyan - [@levonmidoyan](https://github.com/levonmidoyan)

### License
MIT
