#!/usr/bin/env perl
use strict;
use warnings;

# ------------------------------------------
# translate_orfs.pl  (interactive-only)
# Ζητά αλληλουχία DNA από STDIN· μεταφράζει
# όλα τα ORFs (+ και – κλώνος, 3 frames έκαστος)
# ------------------------------------------

print "Δώσε αλληλουχία DNA (A/C/G/T). Τέλος με Ctrl-D (Linux/macOS) ή Ctrl-Z ↵ (Windows):\n";

my $seq = '';
while (<STDIN>) {
    chomp;
    $seq .= uc $_;
}

die "Δεν δόθηκε έγκυρη αλληλουχία!\n" unless $seq =~ /^[ACGT]+$/;

# -------- reverse-complement ----------
(my $revcomp = reverse $seq) =~ tr/ACGT/TGCA/;

# -------- process the six frames ------
process_orfs($seq,     '+');
process_orfs($revcomp, '-');

# -------------- subs ------------------
sub process_orfs {
    my ($dna, $strand) = @_;
    for my $frame (0 .. 2) {                 # frames 0,1,2  ➜ +1,+2,+3
        my $pos = $frame;
        while ($pos < length($dna) - 2) {
            if (substr($dna, $pos, 3) eq 'ATG') {   # start codon
                my $start = $pos;
                $pos += 3;
                while ($pos < length($dna) - 2) {
                    my $codon = substr($dna, $pos, 3);
                    if ($codon =~ /^(TAA|TAG|TGA)$/) {  # stop codon
                        my $orf_dna = substr($dna, $start, $pos - $start + 3);
                        my $protein = translate($orf_dna);
                        print join("\t",
                                   $strand,          # + / –
                                   $frame + 1,       # 1-3
                                   $start + 1,       # 1-based start
                                   $pos + 3,         # 1-based stop
                                   $protein), "\n";
                        last;                        # συνέχισε μετά το stop
                    }
                    $pos += 3;
                }
            }
            else { $pos += 3 }
        }
    }
}

sub translate {
    my ($dna) = @_;
    my %code = qw/
        TTT F TTC F TTA L TTG L TCT S TCC S TCA S TCG S
        TAT Y TAC Y TAA * TAG * TGT C TGC C TGA * TGG W
        CTT L CTC L CTA L CTG L CCT P CCC P CCA P CCG P
        CAT H CAC H CAA Q CAG Q CGT R CGC R CGA R CGG R
        ATT I ATC I ATA I ATG M ACT T ACC T ACA T ACG T
        AAT N AAC N AAA K AAG K AGT S AGC S AGA R AGG R
        GTT V GTC V GTA V GTG V GCT A GCC A GCA A GCG A
        GAT D GAC D GAA E GAG E GGT G GGC G GGA G GGG G /;
    my $prot = '';
    for (my $i = 0; $i < length($dna) - 2; $i += 3) {
        $prot .= $code{ substr($dna, $i, 3) } // 'X';
    }
    return $prot;
}
