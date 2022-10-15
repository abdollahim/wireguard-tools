#set -euo pipefail
DATE=$(date +%Y-%m-%d\ %H:%M:%S)

WG_TEMP_FILE="/tmp/wg_peers_temp"
WG_CONFIG_FILE="/etc/wireguard/wg0.conf"

# get all connected Peers by wg command and save the result into the file.
$(wg | grep -B1 -A4 endpoint > $WG_TEMP_FILE)

i=1
count=$(grep peer $WG_TEMP_FILE | wc -l)

# get all Peers (by PublicKey)
for connected in $(grep peer $WG_TEMP_FILE | awk '{print $2}')
do
  # search client name by Peer's PublicKey
  client="\033[92m"$(grep -B1 $connected $WG_CONFIG_FILE | grep -v PublicKey)"\033[0m"

  # get other details for each client
  #endpoint=$(grep -A4 $connected $WG_TEMP_FILE | grep endpoint | awk -F':' '{print $2}')
  allowed="Assigned IP\t: \033[91m"$(grep -A4 $connected $WG_TEMP_FILE | grep allowed | awk -F':' '{print $2}')"\033[0m"
  latest="Last seen\t: "$(grep -A4 $connected $WG_TEMP_FILE | grep latest | awk -F':' '{print $2}')
  transfer="Transferred\t: \033[36m"$(grep -A4 $connected $WG_TEMP_FILE | grep transfer | awk -F':' '{print $2}')"\033[0m"

  #printf "[%d/%d]: %s\n\t%s\n\t%s\n\t" "$(i)" "$(count)" "$(client)" "$(latest)" "$(transfer)"
  echo -e "[$i/$count]: $client\n\t$allowed\n\t$latest\n\t$transfer"
  i=$(expr $i + 1)
done

echo -e "--------------------------------------"
echo -e "${DATE}\t: \033[92m$count Clients connected.\033[0m"
