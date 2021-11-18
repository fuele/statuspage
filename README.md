
## Duckdns.org
Create an account with duck dns.org and note down the token and domain.

# Installation

First create a namespace with:
```
kubectl create namespace statuspage
```

Next create a secret in that namespace
```
kubectl create secret generic duckdns
```

Get the base64 encoded token by running
```
echo -n <token> | base64
```

Then plug that into your secret with 
```
kubectl edit secret duckdns -n statuspage
```
Add the following and paste in your base64 encoded key.
```
data:
  TOKEN: <base64 token>
```

