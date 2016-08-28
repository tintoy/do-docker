# Docker on DigitalOcean with Terraform and Ansible

Create a file called `credentials.tf` in the same folder as `main.tf`, with the following contents:

```hcl
variable "digitalocean_token" {
    default = "Your_DigitalOcean_API_Token"
}
```

Then run:

* `terraform apply`
* `ansible all -m ping`
* Exactly 1 of:
	* `./install-docker.bash`
	* OR:
	* `ansible-playbook ./playbooks/docker.yml`
* Have a play.
* `terraform destroy`
