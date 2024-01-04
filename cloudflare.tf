### Cloudflare ###

variable "cloudflare_api_token" {
    type = string
    description = "Cloudflare API Token"
    sensitive = true
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
  sensitive   = true
}

variable "cloudflare_account_id" {
    type        = string
    description = "Cloudflare Account ID"
    sensitive   = true
}

variable "cloudflare_domain" {
  type        = string
  default     = "nickvazquez.com"
  description = "Cloudflare Domain name"
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "test1"
  value   = aws_instance.app_server.public_ip
  type    = "A"
  ttl     = 1
  proxied = true 
}