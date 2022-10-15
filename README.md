# wireguard-tools
Some useful tools to manage and control Wireguard servers.

## 1. wg-show-beautifier.sh
This is a bash script is used to get the Peer description/name from the Wireguard configuration file and merge them into the wg output we get by running commands "wg" or "wg show". It has different colors for Peer details.

### Usage
To use this bash script you should add a new line between [Peer] and PrivateKey and write your description as a comment to see when you run the script.

### Example

Wireguard configuration file:
```
[Peer]
#Name: Home-PC
PrivateKey = XXXXXX
AllowedIPs = XXXXXX
```

Script output:
```
[1/10]: # Name: Home-PC
        Assigned IP     :  XXXXXX
        Last seen       :  34 seconds ago
        Transferred     :  69.07 MiB received, 1.58 GiB sent
...
```

Inspired by this [Link](https://www.reddit.com/r/WireGuard/comments/gyzzk1/quick_script_for_a_simplified_wg_show_output/)

## Contributing
 - Contributions are welcome. Feel free to open a pull request with your changes or new features related to these tools.
