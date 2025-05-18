while (<>)
{
    if (/^>\S+\|(\w+)\|/) #xreiazomai 2 arxeia gia na to treksw 
    {
        print "Found accesion: $1\n"; #$1 apo8hkeuetai se aythn thn metavlhth mesw tou w+
    }
}


#1o /:exw regular expression
#^>: leei ston kwdika oti arxise na diavazeis apo thn arxh to file
#s+:psaxnw opoiadhpote mh kena poy yparxoyn (ta petaw apeksw)
#|: pipes 
#w+:apo8hkeuei se mia metavlhth ($Hemoglobin)