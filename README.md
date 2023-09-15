<!-- <h1 align="center" style = font-size: 200px>MedScale</h1> -->
<h1 align="center">
    <img src="doc/MS.png" width="300"   overflow= "hidden" alt="medscale-logo">
</h1> 
 
![](https://img.shields.io/badge/language-python-blue.svg)
![](https://img.shields.io/badge/license-Apache-000000.svg)
 
FedVit is a transformer based model for research!| 

## Quick Start 🚀

We provide an end-to-end example for users to start running a medical vit!.

### Step 1. Installation📚

First of all, users need to clone the source code and install the required packages (we suggest python version >= 3.9). 

```bash
git clone https://github.com/erfandarzi/Vit_FL.git


cd medscale
```

#### Use Conda

We recommend using a new virtual environment to install Medscale:

```bash
conda create -n Vit_FL python=3.9
conda activate Vit_FL
```

If your backend is torch, please install torch in advance ([torch-get-started](https://pytorch.org/get-started/locally/)). For example, if your cuda version is 11.3 please execute the following command:

```bash
conda install -y pytorch=1.10.1 torchvision=0.11.2 torchaudio=0.10.1 torchtext=0.11.1 cudatoolkit=11.3 -c pytorch -c conda-forge
```

For users with Apple M1 chips💻:
```bash
conda install pytorch torchvision torchaudio -c pytorch
```

Finally, after the backend is installed, you can install our repository from `source`:

##### From source

```bash
pip install .
```

Now, you have successfully installed the minimal version of our repository. (**Optinal**) 
 ## Example Usage: Federated lung cancer classification 
<h1 align="center">
    <img src="doc/lungcancer.png" width="700"   overflow= "hidden" alt="medscale-logo">
</h1> 

### Downloading Lung cancer dataset📋

You can download lung cancer dataset from kaggle and put it in `dataset/lung`  directory.


 
### Running training script
 
To run a federated learning example with `FedOPT` algorithm, for unbalanced dataset run:
```bash 

python medscale/main.py --cfg scripts/my_configs/FedOPT_Lung_cancer.yaml


```
All adjustable parameters can be found in the second cell. Careful with the `BATCH_SIZE`, as we are using it to parallelize head and time chunk calculations.

To run a federated learning example with `Fedem` algorithm, for unbalanced dataset run:
```bash 




python medscale/main.py --cfg scripts/my_configs/fedem_Lung_cancer.yaml
```
For a personalized , improved method you can run:
```bash 
python medscale/main.py --cfg scripts/my_configs/pfedme_lung_cancer.yaml



python medscale/main.py --cfg scripts/my_configs/fedem_Lung_cancer.yaml
```
For a personalized , improved method you can run:
```bash 
python medscale/main.py --cfg scripts/my_configs/pfedme_lung_cancer.yaml


```

 ## Example Usage: Federated  brain MRI tumor detection 
### Downloading brain MRI tumor dataset📋

You can download brain MRI tumor dataset from kaggle and put it in `dataset/MRI`  directory. 

<h1 align="center">
    <img src="doc/FL_MRI.png" width="700"   overflow= "hidden" alt="medscale-logo">
</h1> 
 
You can put as many MRI data samples in the directory. Download Kaggle datasets and BrainDevelopment.org: [Kaggle 2018](https://www.kaggle.com/navoneel/brain-mri-images-for-brain-tumor-detection), [Kaggle 2020](https://www.kaggle.com/sartajbhuvaji/brain-tumor-classification-mri),Some types of brain tissue are more visible under contrast material and others propagate magnetization differently.
           Proton Density Scan            |  Transverse Magnetization (Type 2) Scan
:----------------------------------------:|:----------------------------------------:
![Scan Type PD](doc/PD.gif)    | ![Scan Type T2](doc/T2.gif)


### Running training script

To run a federated learning example with `FedOPT` algorithm, for unbalanced dataset run:
```bash 

python medscale/main.py --cfg scripts/my_configs/FedOPT_MRI.yaml


python medscale/main.py --cfg scripts/my_configs/FedOPT_MRI.yaml

python medscale/main.py --cfg scripts/my_configs/FedOPT_MRI.yaml


```
All adjustable parameters can be found in the second cell. Careful with the `BATCH_SIZE`, as we are using it to parallelize head and time chunk calculations.

To run a federated learning example with `Fedem` algorithm, for unbalanced dataset run:
```bash 




python medscale/main.py --cfg scripts/my_configs/fedem_MRI.yaml
```
For a personalized , improved method you can run:
```bash 
python medscale/main.py --cfg scripts/my_configs/pfedme_MRI.yaml



python medscale/main.py --cfg scripts/my_configs/fedem_MRI.yaml
```
For a personalized , improved method you can run:
```bash 
python medscale/main.py --cfg scripts/my_configs/pfedme_MRI.yaml


```
## XNAT support to federated pipelines

To add `XNAT` support to the federated learning pipeline, you can use a modified version of XNAT that is optimized and customized for Ubuntu. We recommend you to download the installation script from the [Xnat-Ubuntu](http://github.com/NrgXnat/xnat-docker-compose) repository. After downloading the file, copy it to the root directory of the Ubuntu server and execute it with the command:
```bash 
 sudo bash installScript.sh
 ```
This will start the installation process and configure the processing URL and password in the XNAT admin settings.
 
To enable pipelines in your XNAT system, you must add them and configure the container service for external docker environments. First, navigate to` Administer --> Data Types`

```bash 
 cd Administer/Data Types
 ```
 
  and click on the element for which you want to enable the Execute option. Scroll down to Available Report Actions and add `PipelineScreen_launch_pipeline` and `Build` to the last entry. After submitting this configuration, a 'Execute Pipeline' button should appear when you open a project with the specific SessionData Element. You can now execute a Pipeline for the Project Data. To add a sample pipeline, navigate to `Administer --> Pipeline --> Add Pipeline`
  
  ```bash 
 cd Administer/Pipeline/AddPipeline
 ```
 
  and enter the path `/data/xnat/pipeline/catalog/PipelineTest/SampleHelloWorldPipeline.xml ` Make sure to leave the Name Textfield empty to avoid any bugs! After confirming your settings, the Pipeline will be added to your project, allowing you to test the pipeline engine.
 
The Container Service allows you to add docker containers as pipelines. This requires an external `docker` environment. To connect to this environment, you need to setup a network and configure the communication between the main host and the dockerized XNAT. Finally, you can execute the Pipeline test script to ensure that everything is working as expected.


## License

Our work is under MIT license. Credits to  <a href="https://arxiv.org/abs/2204.05011" target="_blank">Federated Scope</a>   for their amazing pipeline.
 
