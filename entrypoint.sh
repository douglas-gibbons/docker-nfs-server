#!/bin/bash -e

echo "# NFS Exports" > /etc/exports

mkdir -p /exports
echo "/exports *(rw,fsid=0,insecure,no_subtree_check,all_squash,anonuid=1000,anongid=1000)" >> /etc/exports
chmod 770 /exports
chown --recursive 1000:1000 /exports 
echo "Serving /exports"

cat /etc/exports

. /etc/default/nfs-kernel-server
. /etc/default/nfs-common


/sbin/rpcbind

mount -t nfsd nfds /proc/fs/nfsd

# -V 3: enable NFSv3
/usr/sbin/rpc.mountd -N 2 -V 3

/usr/sbin/exportfs -r
# -G 10 to reduce grace time to 10 seconds (the lowest allowed)
/usr/sbin/rpc.nfsd -- $RPCNFSDOPTS $RPCNFSDCOUNT
/sbin/rpc.statd --no-notify
echo "NFS started"

# Ugly hack to do nothing and wait for SIGTERM
while true; do
    sleep 5
done
