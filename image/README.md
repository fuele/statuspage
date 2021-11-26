# Statuspage Metrics image

This image allows you to gather metrics for your internet connection and report them to statuspage.io. 

# Usage
The following environment variables are required.

| Name | Description |
|------| ----------  |
| TOKEN | You statuspage.io API token |
| PAGE_ID | Your statuspage.io page id |
| METRIC_ID | The metric id that is being tracked |
| TARGET_HOST | The host you would like to ping to measure latency. Only required in the latency upload|


# Commands
By default the container does nothing. You must use these commands in order to get and upload the metrics.

## Latency
Run
```
bash ./get-latench.sh | bash ./upload.sh
```

## Bandwidth
Run
```
./fast --silent -m | bash ./upload.sh
```
