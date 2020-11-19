### /etc/ssh/sshd_config (server side)
```
PasswordAuthentication no
PermitEmptyPasswords yes
```

### ~/.ssh/config (local side)
```
AddKeysToAgent yes
Host github.com
  Hostname ssh.github.com
  Port 443
  IdentityFile ~/.ssh/<my_key_file>
  User git
  IgnoreUnknown UseKeychain

Host <server_ip>
  IdentityFile ~/.ssh/<my_key_file>
  Compression no
  User kent
  TCPKeepAlive yes
  ServerAliveInterval 60

Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/<my_key_file>
```

### Mirror a server-side repository to your local machine
### sshfs synchronizes all the files
### Make the mount:
```
sshfs -o auto_cache,reconnect,no_readahead <server_ip>:/home/qtreh/deepo/thoth /mnt/ssh2/thoth
```

### Open with your editor of choice. Note: searching in all files is very slow.
```
atom /mnt/ssh2/thoth
```

### deletes local files? might be unnecessary anyway
```
fusermount -u /mnt/ssh2/thoth
```

### Valuable source: https://stackoverflow.com/questions/39033817/is-the-editor-atom-able-to-open-projects-on-a-remote-server
