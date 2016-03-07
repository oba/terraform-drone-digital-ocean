# terraform-drone-digital-ocean

Terraform code for running Drone.io on a DigitalOcean Droplet for $5 per month.

## Requirements:

* [BitBucket](https://bitbucket.org/) account.
* [Terraform](https://www.terraform.io/).
* [Digital Ocean](https://www.digitalocean.com/) account

## Usage

### Setup BitBucket OAuth Consumer

Visit your BitBucket account, and visit the `settings` page.
Go to `OAuth` and add a `Consumer`.

For `Callback URL`:

Enter anything for now. Change this later with the Droplet IP. See below.

For `Permissions` tick:

* Account: Email
* Account: Read
* Team Membership: Read
* Repositories: Read
* Webhooks: Read and Write

### Deploy

    git clone https://github.com/oba/terraform-drone-digital-ocean.git

    terraform plan \
        -var "do_token=<YOUR-DIGITAL-OCEAN-TOKEN>" \
        -var "private_key=<YOUR-PRIVATE-KEY>" \
        -var "public_key=<YOUR-PUBLIC-KEY>" \
        -var "client_id=<VCS-CLIENT-ID>" \
        -var "client_secret=<VCS-CLIENT-SECRET>" \
    ...
    ...
    terraform apply \
        -var "do_token=<YOUR-DIGITAL-OCEAN-TOKEN>" \
        -var "private_key=<YOUR-PRIVATE-KEY>" \
        -var "public_key=<YOUR-PUBLIC-KEY>"
        -var "client_id=<VCS-CLIENT-ID>" \
        -var "client_secret=<VCS-CLIENT-SECRET>" \
    ...
    ...
    details = Droplet Public IP:
        <YOUR-DROPLET-IP>

### Update Callback URL

Re-visit the OAuth page and find the `Consumer` you previously created.
Change the `Callback Url` to `<YOUR-DROPLET-IP>/authorize` using the Terraform output from the command line.

## Notes

This setup uses BitBucket because it is free to host private repos :muscle:.

To change to another service (e.g. Github) in `scripts/setup_drone.sh.tpl` change the following:

    REMOTE_DRIVER=<SERVIEC_TO_USE>
    REMOTE_CONFIG=<SERVICE_CONFIG>

Please visit [here](http://readme.drone.io/setup/overview/) for more details.

Pull requests welcome :v:.