# amazon-eks-nodejs

This repo holds **express api sample** for [Amazon EKS Hands on Lab](https://catalog.us-east-1.prod.workshops.aws/workshops/9c0aa9ab-90a9-44a6-abe1-8dff360ae428/en-US)

## S3 Bucket

There is an issue with the original repository, where images are not loaded due to restricted access to the S3 bucket. For more information, see [No Images Loaded in the Frontend App](https://github.com/joozero/amazon-eks-frontend/issues/2) GitHub Issue.

To load your own images, first you have to provision your own S3 bucket and then upload the images.

To deploy S3 bucket:
```bash
cd terraform
terraform apply
```

To copy AWS Icon images:
```bash
aws s3 cp ./images/ s3://eks-workshop-img-bucket-<account_id>/ --recursive
```

or you can output the upload command via Terraform:
```bash
terraform output
```

## Replace Image URLs in `app.js` file

To make images available, you need to replace image URLs. To output the base image URL, run:
```bash
terraform output
```

To replace the URLs use `update-image-urls` script in `scripts` folder. Before running the script, change the `newBaseUrl` value to the output value from terraform.

To run the script:
```bash
node update-image-urls.js
```

To test if you can access the images (replace account ID with your value), run:
```bash
curl -I https://eks-workshop-img-bucket-339712714478.s3.us-east-1.amazonaws.com/demo-image-0.png
```

You should get `200 OK` response:

![](./docs/curl_response.png)