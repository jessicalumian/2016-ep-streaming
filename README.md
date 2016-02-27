This is a comparison of a [streaming](https://github.com/dib-lab/khmer-protocols/blob/jem-streaming/mrnaseq/1-quality.rst) and nonstreaming ([step one](https://github.com/dib-lab/khmer-protocols/blob/ctb/mrnaseq/1-quality.rst), [step two](https://github.com/dib-lab/khmer-protocols/blob/ctb/mrnaseq/2-diginorm.rst), [step three](https://github.com/dib-lab/khmer-protocols/blob/ctb/mrnaseq/3-big-assembly.rst)) versions of the [Eel Pond mRNASeq Protocol](https://khmer-protocols.readthedocs.org/en/ctb/mrnaseq/).


Start by firing up Amazon EC2 (m3.xlarge for data subset). Instructions on setting up an EC2 are [here](http://angus.readthedocs.org/en/2015/amazon/index.html).

Install git-core for literate resting text extraction
of khmer-protocols. 

```text
sudo chmod a+rwxt /mnt
sudo apt-get -y install git-core
```

Extract commands from protocols, note ctb branch is nonstreaming.
*Note* - for nonstreaming, do -b ctb, for streaming, do -b jem-streaming

```text
cd /home/ubuntu
rm -fr literate-resting khmer-protocols
git clone https://github.com/dib-lab/literate-resting.git
git clone https://github.com/dib-lab/khmer-protocols.git -b ctb

cd khmer-protocols/mrnaseq
```
Extract commands from protocols. 

```text
for i in [1-3]-*.rst
do
   /home/ubuntu/literate-resting/scan.py $i || break
done
```

In another ssh session, run sar to monitor resrouces. Use screen to do so in same window. 
*Note* - ctrl = press control key plus key after.
Start screen:

```text
screen
crtl+a n # creates new window
```

Install sar:

```text
sudo apt-get install sysstat -y
```

Start running sar:

```text
sar -u -r -d -o times.dat 1
```

Go back to previous window:
```text
crtl+a crtl+a
```
**For nonstreaming**

Run commands for pages 1-3 (goes up through trinity assembly). Commands:

```text
for i in [1-3]-*.rst.sh
do
   bash $i
done
```

**For streaming**

```text
bash 1-quality.rst.sh
```

This will generate your assembly in a file called Trinity.fasta!

Use scp to transfer file to local computer (could also use cyberduck, but this is quicker). Fill in with correct paths and < > brackets. **Command for local computer**:

```text
scp -i ~/Downloads/amazon.pem ubuntu@<Public DNS>:/mnt/work/trinity_out_dir/Trinity.fasta ~/2016-ep-streaming 
```
