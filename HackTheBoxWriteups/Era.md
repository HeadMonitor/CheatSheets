# Era - Medium Machine

<img width="150" height="150" alt="EraIcon" src="https://github.com/user-attachments/assets/3191c775-b6b9-4095-8468-ece6e3096285" />

## Enumeration

We scan the machine with Nmap and find 2 open ports, one **ftp** and one **http**.

```bash
nmap -sC -sV ${MACHINE_IP}

Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-07-30 19:13 UTC
Nmap scan report for 10.129.58.101
Host is up (0.057s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.5
80/tcp open  http    nginx 1.18.0 (Ubuntu)
|_http-server-header: nginx/1.18.0 (Ubuntu)
|_http-title: Did not follow redirect to http://era.htb/
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.04 seconds
```
<br/>

We cannot use **ftp** with an anonymous user, as it is disabled.

```bash
ftp ${MACHINE_IP}

Connected to ${MACHINE_IP}
220 (vsFTPd 3.0.5)

Name (${MACHINE_IP}:user): anonymous
331 Please specify the password.
Password:

530 Login incorrect.
ftp: Login failed
```

So we will proceed to the website.

## Website
By putting the machine IP on our browser, we are redirected to `http://era.htb`. Since this isn't a real domain, we must add it to our `/etc/hosts` file.

```bash
sudo nano /etc/hosts

${MACHINE_IP} era.htb
```
<br/>

Upon inspection we do not see anything interesting on the site.

<img width="1920" height="901" alt="image" src="https://github.com/user-attachments/assets/3ed281fb-e6fd-4192-80da-c0e388657659" />
<br/>
<br/>

If we search for Subdomains by Bruteforcing, we will find `http://file.era.htb`.

```bash
ffuf -u http://era.htb/ -w Desktop/SecLists/Discovery/DNS/subdomains-top1million-5000.txt -H "Host: http://FUZZ.era.htb/"
```

