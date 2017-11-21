# apache php5 oci8 Docker test on Oracle Container Cloud Service (OCCS) over ssh to DBCS

### Instructions

### Download packages from OTN

http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html<p>
Need to download:
<p>
instantclient-basic-linux.x64-12.2.0.1.0.zip<br>
instantclient-sdk-linux.x64-12.2.0.1.0.zip<br>

### Build the dbtest

`docker build -t dbtest .`
<p>
See the https://github.com/mikarinneoracle/apache-php5-oci8-test/blob/master/Dockerfile

### Build the dbtestclient based on dbtest

`cd client`<br>
`docker build -t dbtestclient .`
<p>
See the https://github.com/mikarinneoracle/apache-php5-oci8-test/blob/master/client/Dockerfile

### YAML in OCCS to connect to DBCS

Push the dbtestclient to your Docker-hub e.g. `mikarinneoracle/dbtestclient:latest`

<pre>
version: 2
services:
  dbtest:
    image: 'mikarinneoracle/dbtestclient:latest'
    environment:
      - 'DB_USERNAME=SYS'
      - 'DB_PASSWORD=&lt;your pwd&gt;'
      - 'DB_CONNECT=&lt;your dbcs IP&gt;:1521/PDB1.&lt;your domain&gt;.oraclecloud.internal'
      - 'occs:availability=per-pool'
      - 'occs:scheduler=random'
    ports:
      - '80:80/tcp'
</pre>

### Running connection over ssh in OCCS

Create ssh tunnel in the worker node e.g.<p>
opc      15352     1  0 Nov16 ?        00:00:00 ssh -nNT -L 1521:&lt;your dbcs IP&gt;:1521 opc@&lt;your dbcs IP&gt;
<p>
The easiest way is to add your ssh public key to both the dbcs and occs (worker) and then login to occs worker node with ssh -A and then creating the ssh tunnel.
  
#### OCCS YAML to use the dbcs over ssh:

<pre>
version: 2
services:
  dbtestoverssh:
    image: 'mikarinneoracle/dbtestclient:latest'
    environment:
      - 'DB_USERNAME=SYS'
      - 'DB_PASSWORD=&lt;your pwd&gt;''
      - 'DB_CONNECT=127.0.0.1:1521/PDB1.&lt;your domain&gt;.oraclecloud.internal'
      - 'occs:availability=per-pool'
      - 'occs:scheduler=random'
    ports:
      - '80:80/tcp'
    network_mode: host
</pre>


