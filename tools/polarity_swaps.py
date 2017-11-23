def sof_polarity_swap (sector):

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
            return true
        if (pair==5):
            return True

    elif (sector==7):
        if (pair==1):
            return True
#       if (pair==2):
#           return True

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
