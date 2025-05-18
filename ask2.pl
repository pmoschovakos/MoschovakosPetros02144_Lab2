use strict;
use warnings;

while (<>)
{
    if(/^[ATGC]+$/i)
    {
        print "Valid DNA sequence\n";
    }
    else 
    {
        print "Invalid DNA sequence\n";
    }
}

#gia ka8e seira pairnw ena apotelesma gia auto kai ta 4 "Invalid DNA sequence" sto terminal
#/:regular expresion
#^:ksekinaw apo thn arxh ths grammhs
#[ATGC]: ta 4 noukleotidia
#+: ayta ta 4 noukleotidia mporei na ta synanthsw se mia grammh perissotero apo 1 fores
#$:na apo8hkeuontai auta pou vriskw se mia metavlhth
#/i:den ton endiaferoun an einai kefalaia h mikra ta grammata ta vriskei to idio 