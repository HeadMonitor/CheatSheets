### Files & Directories
  ```bash
  pwd                 #Print current working directory
  ls                  #List directory contents
  cd ${DIR}           #Change Directory
  mkdir ${NAME}       #Create a new directory
  rm  ${FILE_OR_DIR}  #Remove files or directories
  cat ${FILE}         # Print file content
  less ${FILE}        # View file content page-by-page
  more ${FILE}        # Like less but more basic
  head ${FILE}        # Show first 10 lines
  tail ${FILE}        # Show last 10 lines
  ```

<br/>

### Permissions & Ownership
```bash
chmod 755 ${FILE}           # Set read/write/execute for user, read/execute for group/others
chmod +x ${FILE}            # Make file executable
chown user ${FILE}          # Change ownership to user
chown user:group ${FILE}    # Change owner and group
```
