#!/usr/bin/env perl

# MAKE SURE YOU HAVE A SWAP FILE ENABLED AND TO MANUALLY CHMOD +X THIS
# Polybar Swap Usage Module

use strict;
use warnings;

# Swap usage
my $swapTotal = `cat /proc/meminfo | grep SwapTotal | awk '{print \$2}'`;
my $swapFree = `cat /proc/meminfo | grep SwapFree | awk '{print \$2}'`;

chomp($swapTotal, $swapFree);

my $swapUsed = $swapTotal - $swapFree;
my $swapUsedPerc = sprintf("%.2f", ($swapUsed / $swapTotal) * 100);

print "$swapUsedPerc%\n";