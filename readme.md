# Webserver Log Analyzer
This is a small query tool for webserver logs.
By formatting the log entries as prolog facts, we can use the logs as a database.

## Nginx configuration

1. Enable the [GeoIP module](http://nginx.org/en/docs/http/ngx_http_geoip_module.html)
2. Create a log format

```
log_format prolog 'l("$server_name", "$remote_addr", $status, "$time_local", "$request_method", "$request_uri", "$geoip_country_code").';
```

3. Use the log format

```
access_log /var/log/nginx/access.log prolog;
```
