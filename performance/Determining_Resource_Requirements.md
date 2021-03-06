# Determining Resource Requirements
John Yocum  
![CC BY-SA 4.0](../images/cc_by-sa_4.png)  



# Storage

## Storage Capacity

**Questions**

- What is the size of single sample of data?
    - And, how many samples are you storing?
- Does your application or process generate any temporary or intermediate data files?
    - If so, you'll need to include that in your storage capacity.
- Can your data be heavily compressed?
    - When determing storage space for backups or data transport, this is important.

## Storage Performance

**Questions**

- Are you working with large numbers of small files?
    - Small file read, and write is always slow. Faster disks will help with this.
- Does your application depend on a database?
    - Most databases use lots of random IO. Fast disks like SSDs can make a big difference.
- Are you storing large amounts of data long term?
    - If it's mostly archival, then speed generally doesn't matter.

# Memory and CPU

## Memory (RAM)

**Questions**

- Does your application work entirely from RAM?
    - Tools like R by default work entirely from RAM. Though, there are packages and techniques to help reduce this usage.
- Are you performing an operation which requires all the data?
    - If you can break up the amount of data you need to work with at a time, you'll reduce memory usage.

## CPU

**Questions**

- Is your application single-threaded?
    - A single-threaded application won't benefit from additional cores, only a higher clock-speed.
- Does it have per-core licensing?
    - If your application license restricts you to, 2 cores. You'll want faster cores, not more of them.
- Does the software vendor recommend a particular CPU brand?
    - Both AMD and Intel have special optmizations in their CPUs. Software in some cases is tune to perform best on a particular brand or generation.

# Recommendations and Tips

## Recommendations

**Stata**

- [Hardware Requirements](http://www.stata.com/support/faqs/windows/hardware-requirements/)
- Minimum
    - 1GB RAM
    - 1GB Disk Space


**ArcGIS**

- [Hardware Requirements](http://desktop.arcgis.com/en/system-requirements/latest/arcgis-desktop-system-requirements.htm#ESRI_SECTION1_4D839759F08146819E273A6DDD01DCBB)
- Minimum
    - 2.2Ghz CPU
    - 2GB RAM
    - 2.8GB Disk Space
    - Video Card with 64MB RAM

## Closing Tips

- Check with your software vendor (if using commercial software)
- Review any software license limitations (look for limits on core count)
- Storage performance is often a bottleneck
- A little extra memory never hurts. Running out of RAM will slow things down drastically.

## Questions?
