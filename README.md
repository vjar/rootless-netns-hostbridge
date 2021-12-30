rootless-netns-hostbridge
===

Utilises sudo and nsenter to move a veth pair from a throwaway container's
netns into the root netns. Essentially boils down to ``sudo nsenter -n -t
`pause_pod_pid` ip link set `veth_ifname` netns 1``

Additionally reapplies the interface addresses, which are otherwise discarded
when the netns changes.

Takes extra interfaces to bridge as variable number of arguments. e.g.
`rootless-netns-hostbridge my-cool-network enp1s0`


Usage
---

```
$ podman network create my-cool-network
/var/home/user/.config/cni/net.d/my-cool-network.conflist
$ podman run --rm -d --name web --network my-cool-network nginx:alpine
d9dae31e9272947647fbcadf6de83892cccec43ca2877c3e84c27fdd3ca6fd60
$ rootless-netns-hostbridge my-cool-network
$ curl 10.89.0.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```
