# About
I had a really crapy home internet connection so I wanted to know how much uptime I was actually getting, so I took advantage of a rasberry pi I had lying around, rigged up a lambda function, and published my results to statuspage.io's free plan. 

If you want to monitor your home internet you can do the same, but you will need the following.
* A local kubernetes cluster at your house. I am using a rasberry pi 4 running k3s. You can do it without kuberntes if you want, but this guide assumes that you have one.
* The ability to port forward on your router.
* A duckdns.org account
* An AWS account
* A statuspage.io account

# Design
A lambda function written in go will run every minute and try to reach your home web server. If it is successful in doing so it will mark it as up in statuspage.io. If it fails it will mark it as down. Duckdns.org is used to provide dynamic dns service.

# Duckdns.org
Create an account with duck dns.org and note down the token and domain.

# Statuspage.io
Create an account. Click components. Add component. Add a name and description and leave the rest as default. Click save component. Click on your new component, scroll down to the bottom and note the `Component API ID`. 
Click on your avatar in the bottom left of your screen to access the user menu. Click API info. At the bottom of the screen you should see your api key in a grey box. Note this token down too.

# Web server installation

## Kubernetes manual work
Login to your kubernetes cluster and create a namespace with:
```
kubectl create namespace statuspage
```

Next create an empty secret to hold your duckdns token in that namespace
```
kubectl create secret generic duckdns
```

Secrets must be encoded. Get the base64 encoded token by running and filling in the token you got from duckdns.org.
```
echo -n <token> | base64
```

Plug that into your secret by running 
```
kubectl edit secret duckdns -n statuspage
```
Add the following and paste in your base64 encoded key.
```
data:
  TOKEN: <base64 token>
```
## helm install
In this repo, navigate to charts and open values.yaml. Fill in the missing duckdns domain name.
Next run
```
helm install statuspage -n statuspage . -f values.yaml
```
This should install everything. You can verify it's working by running 
```
curl http://localhost:30007
```
Note that it only needs to return any response to the lambda function to be marked as up. Even a 40x or 50x response is sufficient.

# Port forwarding
Next set the port forwarding on your router to the new service running on your node's IP and port 30007.

# Lambda function
The lambda function is in another repo. Check out https://github.com/fuele/statuspage-updater
It will provide you with instructions on how to set it up and what values you will need.


