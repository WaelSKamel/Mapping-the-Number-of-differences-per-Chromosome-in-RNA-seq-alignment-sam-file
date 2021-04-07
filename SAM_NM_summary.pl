#!/usr/bin/perl -w
use warnings;
$samfile = $ARGV[0];
open FILEONE, $samfile ;
while (<FILEONE>)

{
chomp;
@array = split(/\t/, $_);

unless ($array[0] =~ m/@/) #ignore header
{

#extract flag information 

$samflag=$array[1];

#extract chromosome information 

$chr=$array[2];

#start counting flags/chr information 

$chr_samflag = "$chr\t$samflag";
$Flag_counts{$chr_samflag}++;

#start counting mismatch information as well, if using star aligner , we are aiming for :
# NM:i:count Number of differences (mismatches plus inserted and deleted bases) between the sequence and reference.

$NM = $array[-2];
@Number_of_differences = split(/\:/, $NM);

$differences_counts{$chr_samflag} += $Number_of_differences[2];
}

}

#printing extracted information

foreach $key (sort keys %Flag_counts)
{
	print"$key\t$Flag_counts{$key}\t$differences_counts{$key}\n" 
}
