rootless-netns-hostbridge
===

Utilises sudo and nsenter to move a CNI-provided veth pair's interface from a
throwaway container's netns into the host netns. Essentially boils down to
``sudo nsenter -n -t `pause_pod_pid` ip link set `veth_ifname` netns 1``

Additionally reapplies the interface addresses, which are otherwise discarded
when the netns changes.

Takes extra interfaces to bridge as variable number of arguments, e.g.
`./rootless-netns-hostbridge net enp1s0`. This will create a new bridge
interface and reapply the addresses onto the bridge interface instead.


Usage
---

```
$ podman network create my-cool-network
/var/home/user/.config/cni/net.d/my-cool-network.conflist
$ podman run --rm -d --name web --network my-cool-network nginx:alpine
d9dae31e9272947647fbcadf6de83892cccec43ca2877c3e84c27fdd3ca6fd60
$ ./rootless-netns-hostbridge my-cool-network
$ ip route get 10.89.0.2
10.89.0.2 dev my-cool-network src 10.89.0.3 uid 1000
    cache
$ curl 10.89.0.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```
