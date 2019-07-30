# Reverse Proxy Log Analyzer

## Nginx log format
log_format prolog 'l("$server_name", "$remote_addr", $status, "$time_local", "$request_method", "$request_uri", "$geoip_country_);