### Cloudflare ###

provider "cloudflare" {
  api_token = "o0fZ1c5K0UecuBVZm2cO1vFsylg41JWNht5i_Lth"
}

variable "zone_id" {
  type        = string
  default     = "e5333a972eacce7e771ea4532eb5d7c8"
  description = "Cloudflare Zone ID"
}

variable "account_id" {
    type        = string
    default     = "534018189da378fd664bcc271c90f668"
    description = "Cloudflare Account ID"
}

variable "domain" {
  type        = string
  default     = "nickvazquez.com"
  description = "Cloudflare Domain name"
}

resource "cloudflare_record" "www" {
  zone_id = var.zone_id
  name    = "test1"
  value   = aws_instance.app_server.public_ip
  type    = "A"
  ttl     = 1
  proxied = true 
}