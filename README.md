# apache-php5-oci8-test

### Instructions

### Download packages from OTN

http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html<p>
Need to download:
<p>
instantclient-basic-linux.x64-12.2.0.1.0.zip<br>
instantclient-sdk-linux.x64-12.2.0.1.0.zip<br>
<p>
See the https://github.com/mikarinneoracle/apache-php5-oci8-test/blob/master/Dockerfile

### Build the dbtest

`docker build -t dbtest .`

### Build the dbtestclient based on dbtest

`cd client`<br>
`docker build -t dbtestclient .`
<p>
See the https://github.com/mikarinneoracle/apache-php5-oci8-test/blob/master/client/Dockerfile

### YAML in OCCS to connect to DBCS

<pre>
version: 2
services:
  dbtestssh:
    image: 'mikarinneoracle/dbtestclient:latest'
    environment:
      - 'DB_USERNAME=SYS'
      - 'DB_PASSWORD=<your pwd>'
      - 'DB_CONNECT=<your dbcs IP>:1521/PDB1.<your domain>.oraclecloud.internal'
      - 'occs:availability=per-pool'
      - 'occs:scheduler=random'
    ports:
      - '80:80/tcp'
</pre>

### Running connection over ssh in OCCS

Create ssh tunnel e.g.<p>
opc      15352     1  0 Nov16 ?        00:00:00 ssh -nNT -L 1521:<your dbcs IP>:1521 opc@<your dbcs IP>

<pre>
version: 2
services:
  dbtestssh:
    image: 'mikarinneoracle/dbtestclient:latest'
    environment:
      - 'DB_USERNAME=SYS'
      - 'DB_PASSWORD=<your pwd>'
      - 'DB_CONNECT=<your IP>:1521/PDB1.<your domain>.oraclecloud.internal'
      - 'occs:availability=per-pool'
      - 'occs:scheduler=random'
    ports:
      - '80:80/tcp'
    network_mode: host
</pre>


