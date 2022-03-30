# Initial Setup - based setup with two connected centos7 nodes - both with pg13 installed

As per details below:
* pg13-db1 has ip address 192.168.60.5
* pg13-db2 has ip address 192.168.60.6
* they can both ping each other



## vagrant ssh db1

* pg13-db1 has ip address 192.168.60.5
```
~/projects/vagrant-c7-pg13-pg13 $ vagrant ssh db1
Last login: Wed Mar 30 20:49:46 2022 from 10.0.2.2
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[vagrant@pg13-db1 ~]$ ifconfig -a.
-bash: ifconfig: command not found
[vagrant@pg13-db1 ~]$ ifconfig -a
-bash: ifconfig: command not found
[vagrant@pg13-db1 ~]$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 77703sec preferred_lft 77703sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:65:39:a2 brd ff:ff:ff:ff:ff:ff
    inet 192.168.60.5/24 brd 192.168.60.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe65:39a2/64 scope link
       valid_lft forever preferred_lft forever
```


* ping pg13-db1
```
[vagrant@pg13-db1 ~]$ ping 192.168.60.6
PING 192.168.60.6 (192.168.60.6) 56(84) bytes of data.
64 bytes from 192.168.60.6: icmp_seq=1 ttl=64 time=0.460 ms
64 bytes from 192.168.60.6: icmp_seq=2 ttl=64 time=0.592 ms
^C
```

## vagrant ssh db2

* pg13-db2 has ip address 192.168.60.6
```
~/projects/vagrant-c7-pg13-pg13 $ vagrant ssh db2
Last login: Wed Mar 30 20:52:04 2022 from 10.0.2.2
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[vagrant@pg13-db2 ~]$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 76350sec preferred_lft 76350sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:fd:fb:49 brd ff:ff:ff:ff:ff:ff
    inet 192.168.60.6/24 brd 192.168.60.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fefd:fb49/64 scope link
       valid_lft forever preferred_lft forever
```

* ping pg13-db1
```
[vagrant@pg13-db2 ~]$ ping 192.168.60.5
PING 192.168.60.5 (192.168.60.5) 56(84) bytes of data.
64 bytes from 192.168.60.5: icmp_seq=1 ttl=64 time=0.473 ms
64 bytes from 192.168.60.5: icmp_seq=2 ttl=64 time=0.658 ms
64 bytes from 192.168.60.5: icmp_seq=3 ttl=64 time=0.610 ms
^C
--- 192.168.60.5 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 0.473/0.580/0.658/0.080 ms
```


