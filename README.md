# cookiecutter-cdk

use this cookiecutter project to create a new project from the template


## Usage

```bash
cookiecutter gh:imprivata-cloud/cookiecutter-cdk
full_name [Nate Marks]: 
email [nmarks@imprivata.com]: 
github_username [imprivata-cloud]: 
# the project name should be hyphenated
# I use the hyphenated project name for teh github project and the project root directory
project_name [cdk-my-project-name]: cdk-example-one
project_slug [cdk_example_one]: 
project_short_description [CDK/Boto3 template is a good starting point]: use example one for all the best things!!11!!

# NOTE the root project directory is hyphenated, but the package and module names use underscores
cd cdk-example-one
tree
.
├── app.py
├── cdk_example_one
│ ├── cdk_example_one_stack.py
│ └── __init__.py
├── cdk.json
├── CONTRIBUTE.md
├── GETTING_STARTED.md
├── Makefile
├── pyproject.toml
├── README.md
├── requirements.txt
├── scripts
│ └── initialize_git.sh
└── tests
    ├── __init__.py
    └── unit
        ├── __init__.py
        └── test_{{cookiecutter.project_slug}}_stack.py

4 directories, 14 files


# initialize the git repo. you'll be prompted for the first commit message
bash scripts/initialize_git.sh

# update aws cdk libs
make update_cdk_libs
```
