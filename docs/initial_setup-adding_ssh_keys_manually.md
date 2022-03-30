# Initial Setup - notes on adding ssh keys manually 

Some notes on adding ssh keys manual .. longer-term I want to automate this.

Ref: https://phoenixnap.com/kb/how-to-generate-ssh-key-centos-7


## on db1 setup keys and copy public key to clipboard

```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

e.g.

```
[root@pg13-db1 ~]# ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:XlHEOkvaiojg8bGWhWYCwKlD0P+T39KMSWxUM/1RgT0 root@pg13-db1.dev
The key's randomart image is:
+---[RSA 2048]----+
|+..        +o ooo|
|.+.       +.o..E |
|+  .     ..+ . ..|
|+   .   . +.  .  |
|..  .. +S+.o     |
|.o = .+.=.o      |
|..*.=. *.B       |
| ..=. . * +      |
|  .      .       |
+----[SHA256]-----+
```
and
```
[root@pg13-db1 ~]# cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLgfp/y430PJ
...
1wzj1VWwx2D/vyN root@pg13-db1.dev
```

## on db2 add the public key to 

```
mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
vi ~/.ssh/authorized_keys    
```

```
[root@pg13-db2 ~]# mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys
[root@pg13-db2 ~]# chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
[root@pg13-db2 ~]# vi ~/.ssh/authorized_keys    << paste the id_rsa.pub key >>
[root@pg13-db2 ~]# 
```

## on db1 you can now ssh

```
[root@pg13-db1 ~]# ssh 192.168.60.6
[root@pg13-db2 ~]#
```
