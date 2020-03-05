#!/home/wang/software/anaconda3/bin/python3

import requests

def getGene(url,filename):
    dat=requests.get(url)
    data=dat.json()
    outfile=open(str(filename),"w")
    for i in range(len(data['associations'])):
        symbol=data['associations'][i]['gene']['symbol']
        outfile.write(symbol+'\n')

    outfile.close()


getGene("http://amp.pharm.mssm.edu/Harmonizome/api/1.0/gene_set/MCF7/CCLE+Cell+Line+Gene+Expression+Profiles","CCLE_MCF7diffGene.txt")

getGene("http://amp.pharm.mssm.edu/Harmonizome/api/1.0/gene_set/MCF7/GDSC+Cell+Line+Gene+Expression+Profiles","GDSC_MCF7diffGene.txt")

getGene("http://amp.pharm.mssm.edu/Harmonizome/api/1.0/gene_set/MCF7/BioGPS+Cell+Line+Gene+Expression+Profiles","BioGPS_MCF7diffGene.txt")

