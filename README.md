[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
# Multiplexed 3D atlas of state transitions and immune interactions in colorectal cancer 
<br>
Jia-Ren Lin1,2,*, Shu Wang1,2,3,*, Shannon Coy1,2,4,*, Yu-An Chen1,2, Clarence Yapp1,2, Madison Tyler1,2, Maulik K. Nariya1,2,7, Cody N. Heiser1,5, Ken S. Lau1,6, Sandro Santagata1,2,4,7,†, and Peter K. Sorger1,2,7,#,†

*These (first) authors contributed equally<br>
†These (senior) authors contributed equally<br>

**1** Human Tumor Atlas Network<br>
**2** Ludwig Center at Harvard and Laboratory of Systems Pharmacology, Harvard Medical School, Boston, MA, 02115, USA.<br>
**3** Harvard Graduate Program in Biophysics, Harvard University, Cambridge, MA, 02138, USA.<br>
**4** Department of Pathology, Brigham and Women’s Hospital, Harvard Medical School, Boston, MA 02115, USA.<br>
**5** Program in Chemical & Physical Biology, Vanderbilt University School of Medicine, Nashville, TN, 37232, USA.<br>
**6** Epithelial Biology Center and Department of Cell and Developmental Biology, Vanderbilt University School of Medicine, Nashville, TN, 37232, USA.<br>
**7** Department of Systems Biology, Harvard Medical School, Boston, MA, 02115, USA.<br>
<br>
<img src="./docs/SARDANA_fig1a.png" style="max-width:700px;width:100%">
<br>

## SUMMARY
Advanced solid cancers are complex assemblies of tumor, immune, and stromal cells characterized by high intratumoral variation. We use highly multiplexed tissue imaging, 3D reconstruction, spatial statistics, and machine learning to identify cell types and states underlying morphological features of known diagnostic and prognostic significance in colorectal cancer. Quantitation of these features in high-plex marker space reveals recurrent transitions from one tumor morphology to the next, some of which are coincident with long-range gradients in the expression of oncogenes and epigenetic regulators. At the tumor invasive margin, where tumor, normal, and immune cells compete, T-cell suppression involves multiple cell types and 3D imaging shows that seemingly localized 2D features such as tertiary lymphoid structures are commonly interconnected and have graded molecular properties. Thus, while cancer genetics emphasizes the importance of discrete changes in tumor state, whole-specimen imaging reveals large-scale morphological and molecular gradients analogous to those in developing tissues.
<br>
## DATA AVAILABILITY AND ATLAS IMAGE VIEWING
As part of this paper all images at full resolution, all derived image data (e.g., segmentation masks) and all cell count tables have been released via the NCI-sponsored repository for Human Tumor Atlas Network (HTAN; https://htan-portal-nextjs.vercel.app/). Because the public resource is still undergoing extensive development, an additional version of the data is also available at https://labsyspharm.github.io/HTA-CRCATLAS-1/data.html.  Several of the figure panels in this paper are available with text and audio narration for anonymous on-line browsing using MINERVA software (Rashid et al., 2022), which supports zoom, pan, and selection actions without requiring the installation of software. A Minerva story with an overview of CRC1 (sections 096 and 097) can be found at: cycif.org/crc1-intro and the 25 CRC1 Z-sections can be found at: cycif.org/crc1-3d. The third Minerva story focused on data integration for CRC1 can be found at: https://www.cycif.org/data/lin-wang-coy-2021/viz.html. Other resources, including images of CRC2-17, for this paper can be found at https://www.tissue-atlas.org/atlas-datasets/lin-wang-coy-2021/. We will make all of these MINERVA stories available directly via the published version of this paper; we are currently securing DOIs for these stories to provide a more uniform name space.<br>

## ACCESS FULL DATASET

**IMPORTANT!** Please review the [overall summary and guidance](syn18434611/wiki/602862) for this dataset before continuing!

The full 2.3 TB dataset with all 47 images is available through Amazon Web Services S3 using a "requester pays" model. This means each center will be responsible for paying the $0.10/GB transfer charges for downloading all or part of the data from AWS to a location of their choice. Each center shall nominate one person with access to a center-funded AWS account, or if none exists then they must create an account. This person will manage all data downloads for their center to avoid duplicate downloads and extra charges. Do not use a personal account, as the costs incurred may be significant. The nominated person must email Yu-An_Chen@hms.harvard.edu with the AWS account’s **AWS account ID** and **canonical user ID** which may be found as detailed here: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html#FindingYourAccountIdentifiers. We must receive **both** the  account ID and canonical user ID in order to grant access to the S3 bucket containing the full dataset. After access is granted the images and metadata will be available in the bucket at the following locations: 

```text
s3://htan-tnp-sardana-hms-prerelease/phase-1/data/
s3://htan-tnp-sardana-hms-prerelease/phase-1/metadata/
```

To browse and download the data use either a graphical file transfer application that supports S3 such as [CyberDuck](https://cyberduck.io), or the [AWS CLI tools](https://aws.amazon.com/cli/). A graphical tool may be more convenient but the CLI tools will likely offer higher download speeds. Please refer to the documentation for your chosen tool on how to sign in and enable access to requester-pays buckets. There is unfortunately no web-browser-based mechanism for accessing a requester-pays bucket. Keep in mind the download costs, which will run over $200 for downloading one copy of the entire dataset. For users who wish to perform processing within AWS to avoid transfer charges, note that the bucket is located in the `us-east-1` region so any other resources must be instantiated in this same region. 

The HMS center will commit to making the full dataset available through S3 through at least December 31, 2020. By that time we expect the DCC will be able to take over hosting of the data. 

The following table contains summary biospecimen and file metadata for all 47 sections. Note there is more than one page - use the Next button to see more rows.

|Section|Internal_Biospecimen_ID|Method |Thickness (Î¼m)|Size (GB)|Image Filename      |Metadata Filename        |
|-------|-----------------------|-------|---------------|---------|--------------------|-------------------------|
|1      |WD-76845-001           |H&E    |5              |12.2     |WD-76845-001.ome.tif|WD-76845-001-metadata.csv|
|2      |WD-76845-002           |t-CyCIF|5              |88       |WD-76845-002.ome.tif|WD-76845-002-metadata.csv|
|6      |WD-76845-006           |H&E    |5              |11       |WD-76845-006.ome.tif|WD-76845-006-metadata.csv|
|7      |WD-76845-007           |t-CyCIF|5              |80.2     |WD-76845-007.ome.tif|WD-76845-007-metadata.csv|
|13     |WD-76845-013           |H&E    |5              |11.9     |WD-76845-013.ome.tif|WD-76845-013-metadata.csv|
|14     |WD-76845-014           |t-CyCIF|5              |72.4     |WD-76845-014.ome.tif|WD-76845-014-metadata.csv|
|19     |WD-76845-019           |H&E    |5              |12.7     |WD-76845-019.ome.tif|WD-76845-019-metadata.csv|
|20     |WD-76845-020           |t-CyCIF|5              |83.6     |WD-76845-020.ome.tif|WD-76845-020-metadata.csv|
|24     |WD-76845-024           |H&E    |5              |11       |WD-76845-024.ome.tif|WD-76845-024-metadata.csv|
|25     |WD-76845-025           |t-CyCIF|5              |83.6     |WD-76845-025.ome.tif|WD-76845-025-metadata.csv|
|28     |WD-76845-028           |H&E    |5              |10.1     |WD-76845-028.ome.tif|WD-76845-028-metadata.csv|
|29     |WD-76845-029           |t-CyCIF|5              |74.4     |WD-76845-029.ome.tif|WD-76845-029-metadata.csv|
|33     |WD-76845-033           |H&E    |5              |11.8     |WD-76845-033.ome.tif|WD-76845-033-metadata.csv|
|34     |WD-76845-034           |t-CyCIF|5              |82.2     |WD-76845-034.ome.tif|WD-76845-034-metadata.csv|
|38     |WD-76845-038           |H&E    |5              |11.3     |WD-76845-038.ome.tif|WD-76845-038-metadata.csv|
|39     |WD-76845-039           |t-CyCIF|5              |80.2     |WD-76845-039.ome.tif|WD-76845-039-metadata.csv|
|43     |WD-76845-043           |H&E    |5              |11       |WD-76845-043.ome.tif|WD-76845-043-metadata.csv|
|44     |WD-76845-044           |t-CyCIF|5              |76.6     |WD-76845-044.ome.tif|WD-76845-044-metadata.csv|
|48     |WD-76845-048           |H&E    |5              |11.2     |WD-76845-048.ome.tif|WD-76845-048-metadata.csv|
|49     |WD-76845-049           |t-CyCIF|5              |76.6     |WD-76845-049.ome.tif|WD-76845-049-metadata.csv|
|50     |WD-76845-050           |t-CyCIF|5              |80.2     |WD-76845-050.ome.tif|WD-76845-050-metadata.csv|
|51     |WD-76845-051           |t-CyCIF|5              |76.6     |WD-76845-051.ome.tif|WD-76845-051-metadata.csv|
|52     |WD-76845-052           |t-CyCIF|5              |80.2     |WD-76845-052.ome.tif|WD-76845-052-metadata.csv|
|53     |WD-76845-053           |H&E    |5              |10.5     |WD-76845-053.ome.tif|WD-76845-053-metadata.csv|
|54     |WD-76845-054           |t-CyCIF|5              |74.5     |WD-76845-054.ome.tif|WD-76845-054-metadata.csv|
|58     |WD-76845-058           |H&E    |5              |10.5     |WD-76845-058.ome.tif|WD-76845-058-metadata.csv|
|59     |WD-76845-059           |t-CyCIF|5              |80.2     |WD-76845-059.ome.tif|WD-76845-059-metadata.csv|
|63     |WD-76845-063           |H&E    |5              |10.5     |WD-76845-063.ome.tif|WD-76845-063-metadata.csv|
|64     |WD-76845-064           |t-CyCIF|5              |74.4     |WD-76845-064.ome.tif|WD-76845-064-metadata.csv|
|68     |WD-76845-068           |H&E    |5              |10.1     |WD-76845-068.ome.tif|WD-76845-068-metadata.csv|
|69     |WD-76845-069           |t-CyCIF|5              |69.5     |WD-76845-069.ome.tif|WD-76845-069-metadata.csv|
|73     |WD-76845-073           |H&E    |5              |9.1      |WD-76845-073.ome.tif|WD-76845-073-metadata.csv|
|74     |WD-76845-074           |t-CyCIF|5              |69.5     |WD-76845-074.ome.tif|WD-76845-074-metadata.csv|
|77     |WD-76845-077           |H&E    |5              |10.5     |WD-76845-077.ome.tif|WD-76845-077-metadata.csv|
|78     |WD-76845-078           |t-CyCIF|5              |69.5     |WD-76845-078.ome.tif|WD-76845-078-metadata.csv|
|83     |WD-76845-083           |H&E    |5              |9.6      |WD-76845-083.ome.tif|WD-76845-083-metadata.csv|
|84     |WD-76845-084           |t-CyCIF|5              |69.5     |WD-76845-084.ome.tif|WD-76845-084-metadata.csv|
|85     |WD-76845-085           |H&E    |4              |10.6     |WD-76845-085.ome.tif|WD-76845-085-metadata.csv|
|86     |WD-76845-086           |t-CyCIF|4              |72.4     |WD-76845-086.ome.tif|WD-76845-086-metadata.csv|
|90     |WD-76845-090           |H&E    |4              |9.9      |WD-76845-090.ome.tif|WD-76845-090-metadata.csv|
|91     |WD-76845-091           |t-CyCIF|4              |72.4     |WD-76845-091.ome.tif|WD-76845-091-metadata.csv|
|96     |WD-76845-096           |H&E    |4              |10.6     |WD-76845-096.ome.tif|WD-76845-096-metadata.csv|
|97     |WD-76845-097           |t-CyCIF|4              |74.5     |WD-76845-097.ome.tif|WD-76845-097-metadata.csv|
|101    |WD-76845-101           |H&E    |4              |10.5     |WD-76845-101.ome.tif|WD-76845-101-metadata.csv|
|102    |WD-76845-102           |t-CyCIF|4              |72.4     |WD-76845-102.ome.tif|WD-76845-102-metadata.csv|
|105    |WD-76845-105           |H&E    |4              |9.6      |WD-76845-105.ome.tif|WD-76845-105-metadata.csv|
|106    |WD-76845-106           |t-CyCIF|4              |69.5     |WD-76845-106.ome.tif|WD-76845-106-metadata.csv|


## Funding
This work was supported by NIH grants U54-CA225088 (PKS, SS), U2C-CA233280 (PKS, SS), U2C-CA233262 (PKS, SS), U2C-CA233291 (CNH, KSL), R01-DK103831 (CNH, KSL), NIH training grant T32-GM007748 (SC), and the Ludwig Center at Harvard (PKS, SS). All HTAN consortium members are named at humantumoratlas.org. Development of computational methods was supported by the Ludwig Cancer Research, by a Team Science Grant from the Gray Foundation, and by the David Liposarcoma Research Initiative. We thank Dana-Farber/Harvard Cancer Center for the use of the Specialized Histopathology Core, which provided histopathology services supported by P30-CA06516. 
<br>
