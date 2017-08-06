Docker NFS Server
================

NFS server where all clients are set to read/write using the same user and group ID.  This saves the permission pains of various clients with different users.

Obviously, consider the security implications of this.

Usage
----

docker run --privileged dougg/docker-nfs-server /exports
