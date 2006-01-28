##These are some general notes that I am documenting about the getMipsInfo
##function:

##There was a serious design flaw with the original code, so I went in and
##changed some of the coding around over the past weekend - 22 January 2006

##The evidence codes that we should take out should be:

mipsECode = c("901.01.03",
              "901.01.03.01",
              "901.01.03.02",
              "901.01.04",
              "901.01.04.01",
              "901.01.04.02",
              "901.01.05",
              "901.01.05.01",
              "901.01.05.02",
              "902.01.09.02",
              "902.01.01.02.01.01",
              "902.01.01.02.01.01.01",
              "902.01.01.02.01.01.02",
              "902.01.01.02.01.02",
              "902.01.01.02.01.02.01",
              "902.01.01.02.01.02.02",
              "902.01.01.04",
              "902.01.01.04.01",
              "902.01.01.04.01.01",
              "902.01.01.04.01.02",
              "902.01.01.04.01.03"
              "902.01.01.04.02",
              "901.01.09.02")

##901.01.03 - overview Information (TAS/NAS)
##901.01.03.01 - review
##901.01.03.02 - text book

##901.01.04 - personal communication (TAS/NAS)
##901.01.04.01 - homepage (Web)
##901.01.04.02 - e-mail address

##901.01.05 - closed information (NAS)
##901.01.05.01 - institution
##901.01.05.02 - private

#902.01.01.02.01.01 - co-immunoprecipitation
##902.01.01.02.01.01.01 - co-immunoprecipitation, native
##902.01.01.02.01.01.02 - co-immunoprecipitation, epitope tag
##902.01.01.02.01.02 - affinity chromatography
##902.01.01.02.01.02.01 - affinity chromatography, native
##902.01.01.02.01.02.02 - affinity chromatography, affinity-tag (GST, His6, MBP, ...) 

##902.01.01.04.01 - mass spectrometry (MS)
##902.01.01.04.01.01 - with in-line two-dimensional liquid chromatography (MudPIT)
##902.01.01.04.01.02 - liquid chromatography coupled to tandem mass spectrometry (LC-MS/MS)
##902.01.01.04.01.03 - matrix-assisted laser desorption/ionization time-of-light
##                     mass spectrometry (MALDI TOF MS)
##902.01.01.04.02 - immuno detection (ELISA, etc.)

##902.01.09.02 - high throughput experiment

##There is the issue of the evidence code:

##901.01.01.01 - PubMed uid

##This code is the sole identifier of 4 complexes: (270.10, 270.20, 475.05, 475.10)
##But the inclusion of the evidence code will allow approximately a third of the
##Krogan Protein Complexes.

##I am of the mind to allow this evidence code and remove the Krogan protein complexes
##manually. All high through - put experimental data is prefaced with 550 in the Mips
##protein complex id's, so a script like this should work:

mips = getMipsInfo(eCode = mipsECode)
mipsM = createMipsMatrix(mips)
cNames = colnames(mipsM)
index = grep("MIPS-550", cNames)
mipsM = mipsM[,-index]

##The rest of the functionality should work properly now. 
