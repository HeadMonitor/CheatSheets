- ### Bash Spawn <br/>
  Spawns an interactive pseudo-terminal **(pty)** running **/bin/bash**, which upgrades a basic shell to behave more like a fully interactive terminal. <br/>

  ```bash
  script /dev/null -c bash
  ```
  or
  ```bash
  python3 -c 'import pty; pty.spawn("/bin/bash")'
  ```
  
