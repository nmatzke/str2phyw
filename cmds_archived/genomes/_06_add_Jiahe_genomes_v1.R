#######################################################
# Get the GCA genome from a protein ID
#######################################################

# NOTE: This works well:
# efetch -db protein -id WP_012146310.1,WP_011083771.1 -format ipg
# Id	Source	Nucleotide Accession	Start	Stop	Strand	Protein	Protein Name	Organism	Strain	Assembly
# 1152511	INSDC	BA000040.2	1037016	1037285	-	BAC46215.1	bsl0950	Bradyrhizobium diazoefficiens USDA 110	USDA110	GCA_000011365.1
# 1152511	INSDC	NWTE01000002.1	337599	337868	+	PDT62215.1	hypothetical protein	Bradyrhizobium diazoefficiens	Y21	GCA_002531995.1
# 1152511	INSDC	CP032617.1	967712	967981	-	QBP19890.1	hypothetical protein	Bradyrhizobium diazoefficiens	110spc4	GCA_004359355.1
# 6342607	RefSeq	NZ_CAMKHO010000002.1	204240	204581	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans		GCF_946228605.1
# 6342607	RefSeq	NZ_CAMKJF010000002.1	203143	203484	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans		GCF_946229185.1
# 6342607	RefSeq	NZ_CAMKUF010000003.1	189035	189376	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans		GCF_946228205.1
# 6342607	RefSeq	NZ_CP038467.1	4830475	4830816	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans	PKL:12	GCF_004684265.1
# 6342607	RefSeq	NZ_CP045913.1	3640323	3640664	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia proteamaculans	336X	GCF_009660185.1
# 6342607	RefSeq	NZ_CP183196.1	4370243	4370584	+	WP_012146310.1	protealysin inhibitor emfourin	Serratia sp. NFX21	NFX21	GCF_048517035.1
# 6342607	RefSeq	NZ_JANUDZ010000006.1	125105	125446	+	WP_012146310.1	protealysin inhibitor emfourin	Serratia sp. BIGb0163	BIGb0163	GCF_024809935.1
# 6342607	RefSeq	NZ_JBFQXR010000001.1	206968	207309	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans	3B-UT	GCF_040932535.1
# 6342607	RefSeq	NZ_JBHIXJ010000001.1	311448	311789	+	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans		GCF_041984865.1
# 6342607	RefSeq	NZ_JBHIYZ010000320.1	925	1266	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans		GCF_041983965.1
# 6342607	RefSeq	NZ_LR134494.1	4003289	4003630	+	WP_012146310.1	protealysin inhibitor emfourin	Serratia quinivorans	NCTC13188	GCF_900638135.1
# 6342607	RefSeq	NZ_MQMU01000009.1	43228	43569	-	WP_012146310.1	protealysin inhibitor emfourin	Serratia proteamaculans	B-59510	GCF_004153785.1
# 6342607	INSDC	CAMKHO010000002.1	204240	204581	-	CAI1606927.1	Uncharacterised protein	Serratia quinivorans		GCA_946228605.1
# 6342607	INSDC	CAMKJF010000002.1	203143	203484	-	CAI1687080.1	Uncharacterised protein	Serratia quinivorans		GCA_946229185.1
# 6342607	INSDC	CAMKUF010000003.1	189035	189376	-	CAI1851106.1	Uncharacterised protein	Serratia quinivorans		GCA_946228205.1
# 6342607	INSDC	JANUDZ010000006.1	125105	125446	+	MCS4268181.1	hypothetical protein	Serratia sp. BIGb0163	BIGb0163	GCA_024809935.1
# 6342607	INSDC	JBFQXR010000001.1	206968	207309	-	MEX3238045.1	protealysin inhibitor emfourin	Serratia quinivorans	3B-UT	GCA_040932535.1
# 6342607	INSDC	CP038467.1	4830475	4830816	-	QBX68810.1	hypothetical protein	Serratia quinivorans	PKL:12	GCA_004684265.1
# 6342607	INSDC	CP045913.1	3640323	3640664	-	QGH62479.1	hypothetical protein	Serratia proteamaculans	336X	GCA_009660185.1
# 6342607	INSDC	MQMU01000009.1	43228	43569	-	RYM62499.1	hypothetical protein	Serratia proteamaculans	B-59510	GCA_004153785.1
# 6342607	INSDC	UAUP01000037.1	19266	19607	+	SPZ62357.1	Uncharacterised protein	Serratia quinivorans	NCTC13189	GCA_900457005.1
# 6342607	INSDC	UGYN01000002.1	3708716	3709057	-	SUI76056.1	Uncharacterised protein	Serratia quinivorans	NCTC11544	GCA_900457075.1
# 6342607	INSDC	LR134494.1	4003289	4003630	+	VEI73094.1	Uncharacterised protein	Serratia quinivorans	NCTC13188	GCA_900638135.1
# 6342607	INSDC	CP183196.1	4370243	4370584	+	XPP46692.1	protealysin inhibitor emfourin	Serratia sp. NFX21	NFX21	GCA_048517035.1
# 

setup='
install.packages("rentrez")
'
library(rentrez)		# for rentrez::entrez_fetch(db="protein", id=MotA_seq_ids[1:170], rettype="fasta")

# R equivalent:
returned_text = rentrez::entrez_fetch(db="protein", id=c("WP_012146310.1","WP_011083771.1"), rettype="ipg")
retdf = read.table(text=returned_text, header=TRUE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)
head(retdf)
dim(retdf)



setup='
install.packages("ape") 			# has a read.FASTA
install.packages("seqinr")		# has a read.fasta
install.packages("rvest")
install.packages("rexpokit")
install.packages("cladoRcpp")
install.packages("phytools")
install.packages("openxlsx")
install.packages("queryup")

library(devtools)
devtools::install_github(repo="nmatzke/BioGeoBEARS")

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("msa")
BiocManager::install("ginmappeR")
devtools::install_github("brouwern/compbio4all")
'

library(seqinr)
library(ape)
library(BioGeoBEARS)
library(openxlsx)
library(ginmappeR)  # for ginmappeR::getNCBIIdenticalProteins(), get_info_from_seqIDs_v1.R::get_IDs_identical_proteins
library(queryup)		# for queryup::query_uniprot, get_info_from_seqIDs_v1.R::get_uniprot_data_on_seqids
library(rentrez)		# for rentrez::entrez_fetch(db="protein", id=MotA_seq_ids[1:170], rettype="fasta")
#library(bio3d)			# for bio3d::pdbsplit; has ANOTHER read.fasta
#library(compbio4all)# for compbio4all::entrez_fetch_list(), rooted_NJ_tree(), print_msa()
# entrez_fetch_list is a wrapper for rentrez::entrez_fetch

sourceall("~/GitHub/str2phy/Rsrc/")

# wd = "~/GitHub/str2phy/ex/MotAB_overlap/"
wd = "~/DropboxUoA/flag/Full_genomes/genomes/"
setwd(wd)

reference_assemblies_df  = read.table(file="reference_assemblies_log.txt", header=FALSE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)
ref_assemblies_names = c("domain", "species.taxid", "species.name", "taxid", "organism.name", "genbank.accession", "ref.from", "ref.to")
names(reference_assemblies_df) = ref_assemblies_names
head(reference_assemblies_df)
dim(reference_assemblies_df)
# 75348     8
table(reference_assemblies_df$domain)
reference_assemblies_df = reference_assemblies_df[reference_assemblies_df$domain=="Bacteria",]

head(reference_assemblies_df)
dim(reference_assemblies_df)


# motAs_unidentified_in_genomes_HITS
load(file="motAs_unidentified_in_genomes_HITS.Rdata")
# motAs_unidentified_in_genomes_IDs_with_hits
load(file="motAs_unidentified_in_genomes_IDs_with_hits.Rdata")
# motAs_unidentified_in_genomes_the_hits_obtained
load(file="motAs_unidentified_in_genomes_the_hits_obtained.Rdata")


head(motAs_unidentified_in_genomes_HITS)
dim(motAs_unidentified_in_genomes_HITS)

returned_text = rentrez::entrez_fetch(db="protein", id=c("WP_012146310.1","WP_011083771.1"), rettype="ipg")
retdf = read.table(text=returned_text, header=TRUE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)
head(retdf)
dim(retdf)

motAs_unidentified_in_genomes_HITS$seqid

returned_text = rentrez::entrez_fetch(db="protein", id=motAs_unidentified_in_genomes_HITS$seqid, rettype="ipg")
retdf = read.table(text=returned_text, header=TRUE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)
head(retdf)
dim(retdf)

write.table(x=retdf, file="motAs_unidentified_in_genomes_HITS_identical_prots_genomes.txt", append=FALSE, quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)
retdf = read.table(file="motAs_unidentified_in_genomes_HITS_identical_prots_genomes.txt", header=TRUE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)

#######################################################
# Annotate the assemblies which are reference material
#######################################################
head(retdf)
patterns = firstwords(strings=retdf$Assembly, split="\\.")
noNA_TF = !is.na(patterns)
noNA_nums = (1:length(noNA_TF))[noNA_TF]
patterns_noNAs = patterns[noNA_TF]
matchnums_df = match_grepl(patterns=patterns_noNAs, x=reference_assemblies_df$genbank.accession, return_counts=TRUE, return_multiples=TRUE)
matchnums_df

reference_assemblies_df[c(20417,20419),]
reference_assemblies_df[c(18322,18324,18326),]
matchnums_df[grepl(pattern=",", x=matchnums_df$matchnums),]

matchnums = match_grepl(patterns=patterns_noNAs, x=reference_assemblies_df$genbank.accession, return_counts=FALSE, return_multiples=FALSE)
head(matchnums)

retdf$refassembly_row = ""
retdf$refassembly_row[noNA_nums][!is.na(matchnums)] = matchnums[!is.na(matchnums)]
retdf[retdf$refassembly_row != "",]

retdf_check = retdf
retdf_check$refassembly_row[retdf$refassembly_row != ""] = reference_assemblies_df$genbank.accession[as.numeric(retdf$refassembly_row[retdf$refassembly_row != ""])]
retdf_check[retdf_check$refassembly_row != "",]


#######################################################
# Filter out the proteins that come from reference material genomes
#######################################################
protein_Ids_matched_to_reference_assemblies = unique(retdf$Id[retdf$refassembly_row != ""])
protein_Ids_matched_to_reference_assemblies

unmatched_TF = (retdf$Id %in% protein_Ids_matched_to_reference_assemblies) == FALSE
retdf2 = retdf[unmatched_TF,]
dim(retdf)
dim(retdf2)
length(unique(retdf2$Id))


# Subset to GCA
retdf3 = retdf2
retdf3 = retdf2[grepl(pattern="GCF_", x=retdf2$Assembly)==FALSE,]
head(retdf3)
dim(retdf3)
length(unique(retdf3$Id))
length(unique(retdf3$Assembly))

keepGCF_TF = (retdf2$Id %in% unique(retdf3$Id) ) == FALSE
retdf4 = retdf2[keepGCF_TF,]
head(retdf4)
dim(retdf4)

retdf5 = rbind(retdf3, retdf4)
write.table(x=retdf5, file="retdf5.txt", append=FALSE, quote=FALSE, sep="\t", row.names=FALSE, col.names=TRUE)
dim(retdf5)

retdf5_xls = openxlsx::read.xlsx(xlsxFile="retdf5.xlsx", sheet=1, startRow=1)
retdf5_xls$keepTF1[is.na(retdf5_xls$keepTF1)] = ""
head(retdf5_xls)

retdf6_xls = retdf5_xls[retdf5_xls$keepTF1 == 1,]

# Genomes to download to cover Jiahe:
catn(retdf6_xls$Assembly)

#######################################################
# Conclusion: saved a bunch of genomes to:
# /flag/Full_genomes/z_genomes_to_match_Jiahe_proteins 
# genomes_to_match_Jiahe_proteins.txt
#
# Downloaded with:
# 03_genomes_download_w_wget_v1.sh
#######################################################



# https://www.biostars.org/p/367121/
esearch -db assembly -query "GCA_012517435.1" | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}'

# https://www.biostars.org/p/346304/
esearch -db assembly -query "GCA_012517435.1" | esummary | xtract -pattern DocumentSummary -def "NA" -element Taxid Genbank RefSeq Organism

esearch -db assembly -query "GCA_012517435.1" | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Isolate

# https://www.biostars.org/p/429609/
# Rather than extracting the organism and using that for a taxonomy lookup, you can get the same result using elink with -name protein_taxonomy parameter.

