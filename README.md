# Usage

Before running the script make sure your gems are up to date.

```bash
bundle install
```

By default the script counts number of visits. (It is the same as passing `-v` or `--visits` explicitly.)

```bash
./parser.rb webserver.log

/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits
```

`--unique` or `-u` can be used to display number of unique views.

```bash
./parser.rb --unique webserver.log

/index 23 unique views
/home 23 unique views
/contact 23 unique views
/help_page/1 23 unique views
/about/2 22 unique views
/about 21 unique views
```
