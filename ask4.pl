my $protein="MNVEHE _123! LLVEE \$";

while ($protein =~ /([A-Z])/g)  #isodynamo =~ s/[^A-Z]//g; 
{                               #ousiastika to s/[^] einai san to while
    print "$1";
}

print "\n";


#$protein =~ s/[^A-Z]//g;
#print "New sequence: $protein\n";