# Terraform AWS Infrastructure Deployment

## Overview

This project aims to automate the deployment of infrastructure on Amazon Web Services (AWS) using Terraform. It provisions a Virtual Private Cloud (VPC), subnet, internet gateway, route table, security group, key pair, and an EC2 instance, allowing for rapid setup and configuration of a basic AWS environment.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- [Terraform](https://www.terraform.io/downloads.html)
- AWS account with appropriate permissions
- AWS CLI configured with access keys
- Optional: Git (for version control and collaboration)

## Usage

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/your-username/terraform-aws-infrastructure.git
    ```

2. Navigate to the project directory:

    ```bash
    cd terraform-aws-infrastructure
    ```

3. Initialize Terraform:

    ```bash
    terraform init
    ```

4. Review and customize the `terraform.tfvars` file to set your desired variables and configurations.

5. Plan the deployment to preview the changes:

    ```bash
    terraform plan
    ```

6. Apply the Terraform configuration to create the infrastructure:

    ```bash
    terraform apply
    ```

7. After deployment, you should see output indicating the public IP address of the EC2 instance. You can use this IP address to access your instance via SSH.

8. To clean up and destroy the resources when they are no longer needed, run:

    ```bash
    terraform destroy
    ```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Thank you to HashiCorp for developing Terraform.
- Special thanks to the AWS team for providing robust cloud infrastructure services.
