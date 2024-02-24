# This h1finder.sh is script which collect all program names and then collect all assets and save it into wild and non-wild domains 

You can get your API key from https://hackerone.com/settings/api_token/edit  



# Installation

**Please replace your api-token and username**
```
git clone https://github.com/bug-vs-me/h1-asset-fetcher.git
cd h1-asset-fetcher
chmod +x h1finder
mv h1finder /usr/bin/
```

![image](https://github.com/bug-vs-me/h1-asset-fetcher/assets/57610657/724b3e50-5f99-4e9a-90cd-218426a66be7)


# Usage
```
h1finder -t <token> -u <username> -b <true/false>
```

-t = H1 token

-u = h1 username

-b = true or false, if you want bounty only target set it to true if you want vdp only set it to false

**wild.txt files output will look like this:**
```
hackerone-ext-content.com
hackerone-user-content.com
cloudflare.com
cloudflarepartners.com
teams.cloudflare.com
```

**nonwild.txt files output will look like this:**
```
a5s.hackerone-ext-content.com
api.hackerone.com
app.pullrequest.com
b5s.hackerone-ext-content.com
cover-photos-us-east-2.hackerone-user-content.com
```
