# Encryption on Linux

## Encrypting files with openssl

[Theory]{.underline}

If there is a need to transmit files over an insecure medium, like the Internet, OpenSSL can help us to generate files, which are encrypted and thus very secure. In our case, we use OpenSSL to generate public/private keypairs so we are able to encrypt our binary data with those keys. The private key MUST be guarded from non authorized acces since this is the key we decrypt the data with. The public key, can be shared freely and is _**not**_ able **de**crypt the data - just to **en**crypt it.

You may check out the theory behind public/private key cryptography you may check out the following [Wiki](https://en.wikipedia.org/wiki/Public-key_cryptography)

If you don't want to read long explanations, here is how it works: _Person A_ wants to exchange data securely with _person B_ over an insecure medium ( e.g. Internet ). _Person B_ generates a keypair and shares his or her **public key** with _person A_. _Person A_ then encrypts the data with _person B_'s **public key** and sends it over the insecure medium to _person B_. _Person B_ is then able to decrypt the data with his **private key** which has _never_ left his or her computer.

[Requisites]{.underline}

**Generate Certificate Pair**

### Generating neccessary keys

Before we are able to en-/de-crypt our data, we need the keypairs to use. These keys can be generated with OpenSSL.

The command used is:

`openssl req -x509 -nodes -newkey rsa:2048 -keyout private-key.pem -out public-key.pem`

- `-x509` is the certificate type used
- `-nodes` means that the private keys should not be encrypted
- `-newkey` tells OpenSSL to generate new keys
- `rsa:2048` stads for the algorithm and the amount of bits used
- `-keyout` specifies the name of the private key
- `-out` specifies the name of the public key

A premade shell script to automate this task could be:

```bash
#!/bin/sh

echo "Creating directory ~/.myKeys"
#Create directories
mkdir -p ~/.myKeys/

echo "Generating keypair"
#Create Keys
openssl req -x509 -nodes -newkey rsa:2048 -keyout private-key.pem -out public-key.pem

echo "Moving the keys to the directory"
#Move keys to directory
mv private-key.pem ~/.myKeys/
mv public-key.pem ~/.myKeys/

echo "Done"
```

### Encrypting a file

The command used is:

`openssl smime -encrypt -binary -aes-256-cbc -in ~/original_file.bin -out ./encrypted_file.bin -outform DER public-key.pem`

- `smime` this is normally used to encrypt mail messages
- `-encrypt` tells OpenSSL that we want to encrypt data
- `-binary` indicates that we are dealing with binary data (even if it isn't)
- `-aes-256-cbc` establishes the cypher algorithm to use
- `-in` specifies the file to encrypt
- `-out` specifies the filename of the encrypted data
- `-outform` configures the output format for the key
- `public-key.pem` is the public key ( the one that we can share ) we have generated in the previous step

A simple bash script:

```bash
#!/bin/sh

echo "Encrypting $1 to $1.enc "
openssl smime -encrypt -binary -aes-256-cbc -in $1 -out $1.enc -outform DER ~/.myKeys/public-key.pem
echo "Done"
```

### Decrypting a file

The command line is:

`openssl smime -decrypt -in ./encrypted_file.bin -binary -inform DEM -inkey private-key.pem -out ~/original_file.bin`

- `smime` again tells OpenSSL that we are working with smime data
- `-decrypt` starts the decryption process
- `-in` specifies the encrypted file
- `-binary` means that we are working with binary data here (as before)
- `-inform` configures the input key format
- `-inkey` points to the private key ( this is the one we want to keep private at all cost )
- `-out` is the filename of the decrypted data

```bash
#!/bin/sh

echo "Decrypting $1 into ${1/.enc/}"
openssl smime -decrypt -in $1 -binary -inform DEM -inkey ~/.myKeys/private-key.pem -out ${1/.enc/}
echo "Done"
```

[Important]{.underline}

It is important to note that this only works if the data can be fit entirely in RAM. So even though we don't have a theoretical limitation in size, we DO have a limitation in practice, depending on the available RAM.

## Encrypting Disks ( filesystems )

· We need to format the partition we'd like to encrypt. Let's assume that it is /dev/sdx1

`cryptsetup --verbose --verify-passphrase --type luks2 luksFormat /dev/sdx1`

· Now we need to give the mapper a name. I've chosen *enc-part*, but you may choose whatever you want.

`cryptsetup luksOpen /dev/sdx1 enc-part`

· We can check that everything went ok with the command:

`cryptsetup --verbose status enc-part`

· We may optionally fill the new device with zeros (a disk full error will appear at the end, this is normal).

`pv -tpreb /dev/zero | dd of=/dev/mapper/$2 bs=128M`

· Now we have to format the partition. A different file system may be chosen. I'll stick to btrfs

`mkfs.btrfs /dev/mapper/enc-part`

· If we wanted to use a keyfile (so the boot process does not stop upon reaching decryption) we could do

`dd if=/dev/random bs=32 count=1 of=/root/.luksKey`

· First we need to setup  `/etc/crypttab` with the following content

```
# <target name>	<source device>		<key file>	<options>
enc-part	/dev/sdx1	/root/.luksKey
```
Note that in the file above we could leave "none" instead of the keyfile, and the system would ask at every boot what the password is.

· Then we need to specify where to mount the encrypted partition in `/etc/fstab`

```
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda2 during installation
UUID=63c15c0f-546b-488d-b52b-b812d5683e17 /               btrfs   defaults,subvol=@ 0       1
# /boot/efi was on /dev/sda1 during installation
UUID=F1B2-02BC  /boot/efi       vfat    umask=0077      0       1
# /home was on /dev/sda2 during installation
#UUID=63c15c0f-546b-488d-b52b-b812d5683e17 /home           btrfs   defaults,subvol=@home 0       2
/swapfile                                 none            swap    sw              0       0

/dev/mapper/enc-part	/home	btrfs	defaults	0	0
```

· Lastly, we need to add the generated key to the luks keyring

`cryptsetup luksAddKey /dev/sdx1 /root/.luksKey`


To further harden the system, we could put a password upon the grub boot menu and impede - via BIOS - that another system is started.

Sources of information:

- https://www.golinuxcloud.com/how-to-encrypt-hard-disk-partition-luks-linux/

- https://raw.githubusercontent.com/dsancheznet/linux-bash-snippets/main/encrypt_device

- https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/

Articles talking about partition management:

- https://www.howtogeek.com/442101/how-to-move-your-linux-home-directory-to-another-hard-drive/

- https://www.tecmint.com/move-home-directory-to-new-partition-disk-in-linux/

Articles about Key handling

- _Master key on USB Stick_: https://gist.github.com/aleksandarstojkovski/94645293b00ce4cf76c5f1c6440d4a4f
