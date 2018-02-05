def sot_polarity_swap (sector):

    if   (sector==8):
        return True
    elif (sector==22):
        return True
    elif (sector==23):
        return True
    elif (sector==5):
        return True
    elif (sector==15):
        return True
    elif (sector==3):
        return True
    elif (sector==9):
        return True
    elif (sector==1):
        return True
    elif (sector==4):
        return True
    elif (sector==2):
        return True
    elif (sector==12):
        return True
    elif (sector==19):
        return True
    elif (sector==17):
        return True
    else:
        return False

def sbit_polarity_swap (sector, pair):

    # this is a map of which S-bit pairs are polarity swapped
    # this is using electronics numbering i.e.
    #    -  "sectors" or slots are numbered from 1-24
    #    -  pairs are numbered from 0-7

    if      (sector==1):
        if (pair==2):
            return True
        if (pair==4):
            return True

    elif (sector==2):
        if (pair==1):
            return True
        if (pair==3):
            return True

    elif (sector==3):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==4):
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==5):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==6):
            return True

    elif (sector==6):
        if (pair==4):
            return True
        if (pair==5):
            return True

    elif (sector==7):
        if (pair==1):
            return True
        #if (pair==2):
        #   return True # this pair __IS__ inverted but there is something wrong with the board apparently and needs to be masked
        if (pair==2):
           return False # this pair __IS__ inverted but there is something wrong with the board apparently and needs to be masked

    elif (sector==8):
        if (pair==1):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==9):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==7):
            return True

    elif (sector==10):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==11):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==4):
            return True

    elif (sector==12):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True
        if (pair==7):
            return True

    elif (sector==13):
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==14):
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==15):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True

    elif (sector==16):
        if (pair==0):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==17):
        if (pair==1):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==1):
            return True

    elif (sector==18):
        if (pair==3):
            return True

    elif (sector==19):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==4):
            return True
        if (pair==5):
            return True
        if (pair==7):
            return True


    elif (sector==20):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==3):
            return True
        if (pair==5):
            return True

    elif (sector==21):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True
        if (pair==7):
            return True

    elif (sector==22):
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==6):
            return True

    elif (sector==23):
        if (pair==0):
            return True
        if (pair==1):
            return True
        if (pair==2):
            return True
        if (pair==5):
            return True
        if (pair==6):
            return True

    elif (sector==24):
        if (pair==0):
            return True
        if (pair==2):
            return True
        if (pair==6):
            return True

    else:

        return False
