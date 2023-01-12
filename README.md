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
As part of this paper all images at full resolution, all derived image data (e.g., segmentation masks) and all cell count tables have been released via the NCI-sponsored repository for Human Tumor Atlas Network (HTAN; https://htan-portal-nextjs.vercel.app/). Because the public resource is still undergoing extensive development, an additional version of the numerical data is also available at https://www.synapse.org/#!Synapse:syn18434611/wiki/597418. Several of the figure panels in this paper are available with text and audio narration for anonymous on-line browsing using MINERVA software (Rashid et al., 2022), which supports zoom, pan, and selection actions without requiring the installation of software. A Minerva story with an overview of CRC1 (sections 096 and 097) can be found at: cycif.org/crc1-intro and the 25 CRC1 Z-sections can be found at: cycif.org/crc1-3d. The third Minerva story focused on data integration for CRC1 can be found at: https://www.cycif.org/data/lin-wang-coy-2021/viz.html. Other resources, including images of CRC2-17, for this paper can be found at https://www.tissue-atlas.org/atlas-datasets/lin-wang-coy-2021/. We will make all of these MINERVA stories available directly via the published version of this paper; we are currently securing DOIs for these stories to provide a more uniform name space.<br>

**IMPORTANT!** Please review the [overall summary and guidance](syn18434611/wiki/602862) for this dataset before continuing!

The full 2.3 TB dataset with all 47 images is available through Amazon Web Services S3 using a "requester pays" model. This means each center will be responsible for paying the $0.10/GB transfer charges for downloading all or part of the data from AWS to a location of their choice. Each center shall nominate one person with access to a center-funded AWS account, or if none exists then they must create an account. This person will manage all data downloads for their center to avoid duplicate downloads and extra charges. Do not use a personal account, as the costs incurred may be significant. The nominated person must email Madison_Tyler@hms.harvard.edu with the AWS account’s **AWS account ID** and **canonical user ID** which may be found as detailed here: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html#FindingYourAccountIdentifiers. We must receive **both** the  account ID and canonical user ID in order to grant access to the S3 bucket containing the full dataset. After access is granted the images and metadata will be available in the bucket at the following locations: 

```text
s3://htan-tnp-sardana-hms-prerelease/phase-1/data/
s3://htan-tnp-sardana-hms-prerelease/phase-1/metadata/
```

To browse and download the data use either a graphical file transfer application that supports S3 such as [CyberDuck](https://cyberduck.io), or the [AWS CLI tools](https://aws.amazon.com/cli/). A graphical tool may be more convenient but the CLI tools will likely offer higher download speeds. Please refer to the documentation for your chosen tool on how to sign in and enable access to requester-pays buckets. There is unfortunately no web-browser-based mechanism for accessing a requester-pays bucket. Keep in mind the download costs, which will run over $200 for downloading one copy of the entire dataset. For users who wish to perform processing within AWS to avoid transfer charges, note that the bucket is located in the `us-east-1` region so any other resources must be instantiated in this same region. 

The HMS center will commit to making the full dataset available through S3 through at least December 31, 2020. By that time we expect the DCC will be able to take over hosting of the data. 

The following table contains summary biospecimen and file metadata for all 47 sections. Note there is more than one page - use the Next button to see more rows.


## Funding
This work was supported by NIH grants U54-CA225088 (PKS, SS), U2C-CA233280 (PKS, SS), U2C-CA233262 (PKS, SS), U2C-CA233291 (CNH, KSL), R01-DK103831 (CNH, KSL), NIH training grant T32-GM007748 (SC), and the Ludwig Center at Harvard (PKS, SS). All HTAN consortium members are named at humantumoratlas.org. Development of computational methods was supported by the Ludwig Cancer Research, by a Team Science Grant from the Gray Foundation, and by the David Liposarcoma Research Initiative. We thank Dana-Farber/Harvard Cancer Center for the use of the Specialized Histopathology Core, which provided histopathology services supported by P30-CA06516. 
<br>
