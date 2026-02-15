resource "vultr_dns_domain" "soap_coffee" {
  domain = "soap.coffee"
}

resource "vultr_dns_record" "mx_primary" {
  domain   = vultr_dns_domain.soap_coffee.domain
  name     = ""
  type     = "MX"
  data     = "aspmx1.migadu.com"
  priority = 10
}

resource "vultr_dns_record" "mx_secondary" {
  domain   = vultr_dns_domain.soap_coffee.domain
  name     = ""
  type     = "MX"
  data     = "aspmx2.migadu.com"
  priority = 20
}

resource "vultr_dns_record" "txt_spf" {
  domain = vultr_dns_domain.soap_coffee.domain
  name   = ""
  type   = "TXT"
  data   = "\"v=spf1 a mx include:spf.migadu.com ~all\""
}

resource "vultr_dns_record" "txt_dkim" {
  domain = vultr_dns_domain.soap_coffee.domain
  name   = "default._domainkey"
  type   = "TXT"
  data   = "\"v=DKIM1; k=rsa; s=email; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2cvDAUmVc1lHEM8n5uP7IbHWTuSylDz2fcEFAF9SWVJeS4TyJ0mNgGJArtlisZm6j5JMhM0AKp63ak9+kgPJtep4WaORliApwktAL578S9ISL1O4EbGfPo4Jc8aEPXy2GoRN5+TWBMDJmQP2z1i4T15jzLEf2Wws2RyfvTXdM1wIDAQAB\""
}

resource "vultr_dns_record" "txt_dmarc" {
  domain = vultr_dns_domain.soap_coffee.domain
  name   = "_dmarc"
  type   = "TXT"
  data   = "\"v=DMARC1; p=none; fo=1; rua=mailto:admin@soap.coffee\""
}

resource "vultr_dns_record" "txt_atproto" {
  domain = vultr_dns_domain.soap_coffee.domain
  name   = "_atproto.lthms"
  type   = "TXT"
  data   = "\"did=did:plc:g3m5ipqdodqbabd4ixjoosxj\""
}
