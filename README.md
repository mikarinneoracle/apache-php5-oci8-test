# apache-php5-oci8-test

### Instructions

### Download packages from OTN

[http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html](http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html)<p>
Need to download:
<p>
instantclient-basic-linux.x64-12.2.0.1.0.zip<br>
instantclient-sdk-linux.x64-12.2.0.1.0.zip<br>
<p>
See the [Dockerfile](Dockerfile)

### Build the dbtest

`docker build -t dbtest .`

### Build the dbtestclient based on dbtest

`cd client`<br>
`docker build -t dbtestclient .`

### YAML in OCCS

### Running connection over ssh in OCCS




